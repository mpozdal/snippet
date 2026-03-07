import AppKit
import Observation
import SwiftUI

@Observable
class SettingsManager {
    var launchAtLogin: Bool {
        didSet { UserDefaults.standard.set(launchAtLogin, forKey: "launchAtLogin") }
    }

    var theme: String {
        didSet { UserDefaults.standard.set(theme, forKey: "theme") }
    }

    var fontSize: Double {
        didSet { UserDefaults.standard.set(fontSize, forKey: "fontSize") }
    }

    var fontName: String {
        didSet { UserDefaults.standard.set(fontName, forKey: "fontName") }
    }

    var backgroundColorHex: String {
        didSet { UserDefaults.standard.set(backgroundColorHex, forKey: "backgroundColorHex") }
    }

    var backgroundColor: NSColor {
        get { NSColor(hex: backgroundColorHex) ?? .black }
        set { backgroundColorHex = newValue.toHex() ?? "#000000" }
    }

    init() {
        UserDefaults.standard.register(defaults: [
            "launchAtLogin": false,
            "theme": Constants.Theme.defaultTheme,
            "fontSize": 13.0,
            "fontName": "SF Mono",
            "backgroundColorHex": "#1E1E1E"
        ])

        self.launchAtLogin = UserDefaults.standard.bool(forKey: "launchAtLogin")
        self.theme = UserDefaults.standard.string(forKey: "theme") ?? Constants.Theme.defaultTheme
        self.fontSize = UserDefaults.standard.double(forKey: "fontSize")
        self.fontName = UserDefaults.standard.string(forKey: "fontName") ?? "SF Mono"
        self.backgroundColorHex = UserDefaults.standard.string(forKey: "backgroundColorHex") ?? "#1E1E1E"
    }
}
