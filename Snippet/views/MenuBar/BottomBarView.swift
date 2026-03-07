import SwiftUI

struct BottomBarView: View {
    var body: some View {
        HStack {
            SettingsLink { Text("Preferences") }
                .buttonStyle(.borderless)

            Spacer()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .frame(width: Constants.Panels.bottomWidth, height: Constants.Panels.bottomHeight)
        .background(
            RoundedRectangle(cornerRadius: Constants.Panels.cornerRadius)
                .fill(.ultraThinMaterial)
        )
    }
}
