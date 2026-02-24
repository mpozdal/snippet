import Highlighter
import Observation
import SwiftUI

@Observable
class CodeFormatter {
    private let highlightr = Highlighter()

    var currentTheme: String = "atom-one-dark"

    init() {
        setTheme(theme: currentTheme)
    }

    func setTheme(theme: String) {
        highlightr?.setTheme(theme)

        currentTheme = theme
    }

    var themeBackgroundColor: Color {
        let _ = currentTheme

        if let nsColor = highlightr?.theme.themeBackgroundColour {
            return Color(nsColor: nsColor)
        }

        return Color.black
    }

    func getHighlightedCode(text: String, language: String?) -> AttributedString {
        guard let highlighted = highlightr?.highlight(text, as: language) else {
            return AttributedString(text)
        }

        return AttributedString(highlighted)
    }
}
