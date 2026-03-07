import Highlighter
import Observation
import SwiftUI

class CodeFormatter {
    private let highlightr = Highlighter()

    private var defaultTheme: String = Constants.Theme.defaultTheme

    func getThemeBackgroundColor(theme: String?) -> Color {
        highlightr?.setTheme(theme ?? defaultTheme)

        if let nsColor = highlightr?.theme.themeBackgroundColour {
            return Color(nsColor: nsColor)
        }

        return Color.black
    }

    func getAvailableThemes() -> [String] {
        return highlightr?.availableThemes() ?? []
    }

    func getSupportedLanguages() -> [String] {
        return highlightr?.supportedLanguages() ?? []
    }

    func getHighlightedCode(text: String, theme: String?, language: String?) -> AttributedString {
        highlightr?.setTheme(theme ?? defaultTheme)

        guard let highlighted = highlightr?.highlight(text, as: language) else {
            return AttributedString(text)
        }

        return AttributedString(highlighted)
    }
}
