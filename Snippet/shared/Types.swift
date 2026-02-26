import Foundation

struct SourceApp: Sendable {
    let name: String
    let bundleId: String
}

nonisolated extension SourceApp: Codable {}

extension SourceApp {
    static var unknown: SourceApp {
        SourceApp(name: "Unknown", bundleId: "Unknown")
    }
}
