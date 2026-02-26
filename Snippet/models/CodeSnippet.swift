import Foundation
import SwiftData

@Model
final class CodeSnippet {
    var id: UUID
    var title: String
    var code: String
    var timestamp: Date
    var theme: String
    var sourceApp: SourceApp

    init(title: String, code: String, sourceApp: SourceApp, theme: String?) {
        self.id = UUID()
        self.title = title
        self.code = code
        self.timestamp = Date()
        self.theme = theme ?? "atom-dark-one"
        self.sourceApp = sourceApp
    }
}
