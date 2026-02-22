import AppKit

public func readClipboardText() -> String? {
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
