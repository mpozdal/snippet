import AppKit
import Combine
import Observation
import SwiftData
import SwiftUI

@Observable
class ClipboardManager: ObservableObject {
    private(set) var textFromClipboard: String?

    func handleCopyShortcut(context: ModelContext) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let text = self.readClipboardText() {
                guard text != self.textFromClipboard else { return }

                self.textFromClipboard = text

                let newSnippet = CodeSnippet(title: "ClipboardManager.swift", code: text, sourceApp: self.getSourceApplication(), theme: nil)

                context.insert(newSnippet)

                try? context.save()
            }
        }
    }

    private func getSourceApplication() -> SourceApp {
        if let frontmostApp = NSWorkspace.shared.frontmostApplication {
            return SourceApp(
                name: frontmostApp.localizedName ?? "Unknown",
                bundleId: frontmostApp.bundleIdentifier ?? "Unknown"
            )
        }

        return SourceApp.unknown
    }

    private func readClipboardText() -> String? {
        let pasteboard = NSPasteboard.general

        guard let rawString = pasteboard.string(forType: .string) else {
            return nil
        }

        let trimmed = rawString.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            return nil
        }

        return trimmed
    }
}
