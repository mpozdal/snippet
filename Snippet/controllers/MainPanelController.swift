import AppKit
import SwiftUI

final class MainPanelController {
    private(set) var isShown = false
    private var panel: NSPanel?
    private var clickMonitor: Any?

    let height: CGFloat = Constants.Panels.mainHeight

    func show(relativeTo button: NSStatusBarButton?) {
        if panel == nil {
            panel = createPanel(width: Constants.Panels.mainWidth, height: height, rootView: MenuPopupView())
        }

        position(panel: panel, relativeTo: button)
        panel?.makeKeyAndOrderFront(nil)
        isShown = true
    }

    func hide() {
        panel?.orderOut(nil)
        isShown = false
    }

    private func position(panel: NSPanel?, relativeTo button: NSStatusBarButton?) {
        guard let panel, let button, let window = button.window else { return }

        let buttonFrame = window.convertToScreen(button.frame)
        let x = buttonFrame.midX - panel.frame.width / 2
        let y = buttonFrame.minY - panel.frame.height

        panel.setFrameOrigin(NSPoint(x: x, y: y))
    }
}
