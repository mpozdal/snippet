import SwiftUI

struct GeneralSettingsView: View {
    @Bindable var settings: SettingsManager

    var body: some View {
        VStack(spacing: 16) {
            SettingRow(title: "Launch on start", content: {
                Toggle("", isOn: $settings.launchAtLogin)
                    .toggleStyle(.switch)
                    .controlSize(.small)
            })
            Spacer()
            SettingRow(title: "Clear all history", content: {
                Button("Clear") {
                    clear()
                }
            })
        }
        .padding()
    }
}

func clear() {
    print("clear")
}
