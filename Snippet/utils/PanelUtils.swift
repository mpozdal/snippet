import AppKit
import SwiftUI

func createPanel<Content: View>(
    width: CGFloat,
    height: CGFloat,
    rootView: Content
) -> NSPanel {
    let hosting = NSHostingController(rootView: rootView)

    let panel = NSPanel(
        contentRect: NSRect(x: 0, y: 0, width: width, height: height),
        styleMask: [.titled, .fullSizeContentView, .nonactivatingPanel],
        backing: .buffered,
        defer: false
    )

    panel.isFloatingPanel = true
    panel.level = NSWindow.Level.statusBar
    panel.backgroundColor = NSColor.clear
    panel.isOpaque = false
    panel.hasShadow = true
    panel.titleVisibility = NSWindow.TitleVisibility.hidden
    panel.titlebarAppearsTransparent = true
    panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

    panel.becomesKeyOnlyIfNeeded = false

    panel.contentView = hosting.view

    return panel
}
