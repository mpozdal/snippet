import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!

    private let mainPanel = MainPanelController()
    private let bottomPanel = BottomPanelController()

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "gauge", accessibilityDescription: nil)
            button.action = #selector(togglePanels)
            button.target = self
        }
    }

    @objc private func togglePanels() {
        if mainPanel.isShown {
            mainPanel.hide()
            bottomPanel.hide()
        } else {
            mainPanel.show(relativeTo: statusItem.button)
            bottomPanel.show(relativeTo: statusItem.button, mainPanelHeight: mainPanel.height)
        }
    }
}
