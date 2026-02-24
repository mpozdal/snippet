import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var eventTap: CFMachPort?
    private var eventTapRunLoopSource: CFRunLoopSource?
    private let clipboardManager = ClipboardManager()

    private let mainPanel = MainPanelController()
    private let bottomPanel = BottomPanelController()

    private var formatter = CodeFormatter()

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "curlybraces", accessibilityDescription: nil)
            button.action = #selector(togglePanels)
            button.target = self
        }

        let eventMask = (1 << CGEventType.keyDown.rawValue)

        let userInfo = UnsafeMutableRawPointer(Unmanaged.passUnretained(clipboardManager).toOpaque())

        if eventTap == nil,
           let tap = CGEvent.tapCreate(
               tap: .cgSessionEventTap,
               place: .headInsertEventTap,
               options: .defaultTap,
               eventsOfInterest: CGEventMask(eventMask),
               callback: handleKeyDown,
               userInfo: userInfo
           )
        {
            eventTap = tap
            let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, tap, 0)
            eventTapRunLoopSource = runLoopSource
            CFRunLoopAddSource(CFRunLoopGetMain(), runLoopSource, .commonModes)
            CGEvent.tapEnable(tap: tap, enable: true)
        }
    }

    func applicationWillTerminate(_ notification: Notification) {
        if let tap = eventTap {
            CGEvent.tapEnable(tap: tap, enable: false)
        }

        if let source = eventTapRunLoopSource {
            CFRunLoopRemoveSource(CFRunLoopGetMain(), source, .commonModes)
            eventTapRunLoopSource = nil
        }

        eventTap = nil
    }

    @objc private func togglePanels() {
        if mainPanel.isShown {
            mainPanel.hide()
            bottomPanel.hide()
            return
        }

        mainPanel.show(relativeTo: statusItem.button, manager: clipboardManager, formatter: formatter)
        bottomPanel.show(relativeTo: statusItem.button, mainPanelHeight: mainPanel.height, formatter: formatter)
    }
}

private func handleKeyDown(proxy: CGEventTapProxy, type: CGEventType, cgEvent: CGEvent, userInfo: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
    let nsEvent = NSEvent(cgEvent: cgEvent)

    if nsEvent?.modifierFlags.contains(.command) == true, nsEvent?.charactersIgnoringModifiers?.lowercased() == "c" {
        if let userInfo = userInfo {
            let manager = Unmanaged<ClipboardManager>.fromOpaque(userInfo).takeUnretainedValue()
            manager.handleCopyShortcut()
        }
    }

    return Unmanaged.passUnretained(cgEvent)
}
