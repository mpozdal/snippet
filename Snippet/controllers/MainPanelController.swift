import AppKit
import SwiftUI

final class MainPanelController {
    private(set) var isShown = false
    private var panel: NSPanel?
    private var clickMonitor: Any?

    let height: CGFloat = Constants.Panels.mainHeight

    func show(relativeTo button: NSStatusBarButton?, manager: ClipboardManager) {
        if panel == nil {
            panel = createPanel(width: Constants.Panels.mainWidth, height: height, rootView: MenuPopupView(manager: manager))
        }

        position(panel: panel, relativeTo: button)
        panel?.makeKeyAndOrderFront(nil)
        isShown = true

        if clickMonitor == nil, let panel = panel {
            clickMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self, weak panel] _ in
                guard let self, let panel = panel else { return }
                if !panel.frame.contains(NSEvent.mouseLocation) {
                    self.hide()
                }
            }
        }
    }

    func hide() {
        panel?.orderOut(nil)
        isShown = false
        // Remove the click monitor if present
        if let monitor = clickMonitor {
            NSEvent.removeMonitor(monitor)
            clickMonitor = nil
        }
    }

    private func position(panel: NSPanel?, relativeTo button: NSStatusBarButton?) {
        guard let panel, let button, let window = button.window else { return }

        let buttonFrame = window.convertToScreen(button.frame)
        let x = buttonFrame.midX - panel.frame.width / 2
        let y = buttonFrame.minY - panel.frame.height

        panel.setFrameOrigin(NSPoint(x: x, y: y))
    }
}
