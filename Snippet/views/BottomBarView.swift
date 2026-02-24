import SwiftUI

struct BottomBarView: View {
    @Environment(CodeFormatter.self) private var formatter

    var body: some View {
        HStack {
            Button("Preferences") {
                if formatter.currentTheme == "atom-one-dark" {
                    formatter.setTheme(theme: "atom-one-light")
                } else {
                    formatter.setTheme(theme: "atom-one-dark")
                }
            }
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
