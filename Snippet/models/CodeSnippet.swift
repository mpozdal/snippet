import Foundation
import SwiftData
import SwiftUI

@Model
final class CodeSnippet {
    var id: UUID
    var title: String
    var code: String
    var timestamp: Date
    var theme: String
    var sourceApp: SourceApp
    var backgroundColorHex: String
    var fontSize: Double

    init(title: String, code: String, sourceApp: SourceApp, theme: String?, fontSize: Double, backgroundColorHex: String) {
        self.id = UUID()
        self.title = title
        self.code = code
        self.timestamp = Date()
        self.theme = theme ?? Constants.Theme.defaultTheme
        self.sourceApp = sourceApp
        self.fontSize = fontSize
        self.backgroundColorHex = backgroundColorHex
    }
}
