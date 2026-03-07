import Foundation

func formatThemeName(text: String) -> String {
    let spaced = text.replacingOccurrences(of: "-", with: " ")
        .replacingOccurrences(of: "_", with: " ")

    return spaced.capitalized
}
