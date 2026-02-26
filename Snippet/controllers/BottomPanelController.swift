import AppKit
import SwiftUI

final class BottomPanelController {
    private var panel: NSPanel?
    private let height: CGFloat = Constants.Panels.bottomHeight
    private var clickMonitor: Any?

    func show(relativeTo button: NSStatusBarButton?, mainPanelHeight: CGFloat) {
        if panel == nil {
            panel = createPanel(width: Constants.Panels.mainWidth, height: height, rootView: BottomBarView())
        }

        position(panel: panel, relativeTo: button, mainPanelHeight: mainPanelHeight)
        panel?.makeKeyAndOrderFront(nil)

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
    }

    private func position(panel: NSPanel?, relativeTo button: NSStatusBarButton?, mainPanelHeight: CGFloat) {
        guard let panel, let button, let window = button.window else { return }

        let buttonFrame = window.convertToScreen(button.frame)
        let x = buttonFrame.midX - panel.frame.width / 2
        let y = buttonFrame.minY - mainPanelHeight - panel.frame.height - 12

        panel.setFrameOrigin(NSPoint(x: x, y: y))
    }
}
