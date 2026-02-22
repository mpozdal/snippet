import Combine
import SwiftUI

class ClipboardManager: ObservableObject {
    @Published var lastCopiedText: String = readClipboardText() ?? "Empty clipboard"

    func handleCopyShortcut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let text = readClipboardText() {
                self.lastCopiedText = text
            }
        }
    }
}
