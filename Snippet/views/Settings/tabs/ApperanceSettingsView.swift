import SwiftUI

struct ApperanceSettingsView: View {
    @Bindable var settings: SettingsManager
    var codeFormatter = CodeFormatter()

    private let availableFonts = ["SF Mono", "Menlo", "Monaco", "Courier", "JetBrainsMono-Regular"]

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Label("Editor Theme", systemImage: "paintbrush.fill")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.secondary)
                SettingRow(title: "Syntax Highlighting", content: {
                    Combo(selected: $settings.theme,
                          list: codeFormatter.getAvailableThemes())
                })

                SettingRow(title: "Image background color", content: {
                    ColorPicker("", selection: Binding(
                        get: { Color(nsColor: settings.backgroundColor) },
                        set: { settings.backgroundColor = NSColor($0) }
                    ))
                })
            }

            VStack(alignment: .leading, spacing: 8) {
                Label("Typography", systemImage: "textformat")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.secondary)

                VStack(spacing: 8) {
                    SettingRow(title: "Font family", content: {
                        Combo(selected: $settings.fontName, list: availableFonts)
                    })
                    SettingRow(title: "Font size", content: {
                        HStack{}.padding(.horizontal, 16)
                        Slider(value: $settings.fontSize,
                               in: 4 ... 36,
                               step: 1,
                               minimumValueLabel: Image(systemName: "textformat.size.smaller"),
                               maximumValueLabel: Image(systemName: "textformat.size.larger"),
                               label: {
                                   Text(String(settings.fontSize) + " px")
                               })

                    })
                }

                Text("Using a monospaced font ensures that your code indentation stays perfectly aligned.")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 4)
            }

            Spacer()
        }
        .padding()
    }
}
