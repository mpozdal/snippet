import CoreGraphics
import Foundation

enum Constants {
    enum Panels {
        static let mainWidth: CGFloat = 450
        static let mainHeight: CGFloat = 350

        static let bottomWidth: CGFloat = 450
        static let bottomHeight: CGFloat = 50

        static let cornerRadius: CGFloat = 30
    }

    enum Theme {
        static let defaultTheme: String = "atom-one-dark"
    }
}

enum SettingsCategory: String, CaseIterable, Identifiable {
    case general = "General"
    case appearance = "Apperance"
    case shortcuts = "Shortcuts"

    var id: String {
        self.rawValue
    }

    var icon: String {
        switch self {
        case .general: return "gearshape"
        case .appearance: return "paintbrush"
        case .shortcuts: return "keyboard"
        }
    }
}
