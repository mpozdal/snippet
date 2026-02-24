import Combine
import Observation
import SwiftUI

@Observable
class ClipboardManager: ObservableObject {
    var lastCopiedText: String = readClipboardText() ?? "Empty clipboard"

    private var formatter = CodeFormatter()

    func handleCopyShortcut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let text = readClipboardText() {
                self.lastCopiedText = text

                let code = self.formatter.getHighlightedCode(text: self.lastCopiedText, language: nil)

                copyPrettyCodePNGToClipboard(code)
            }
        }
    }
}
