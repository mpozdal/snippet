import SwiftUI

struct MenuPopupView: View {
    @ObservedObject var manager: ClipboardManager

    var body: some View {
        VStack {
            Text("Last copied:")
                .font(.caption)
                .foregroundColor(.gray)

            Text(manager.lastCopiedText)
                .font(.body)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.1))
                .cornerRadius(8)

            Spacer()
        }
        .padding()
        .frame(width: Constants.Panels.mainWidth, height: Constants.Panels.mainHeight)
        .background(
            RoundedRectangle(cornerRadius: Constants.Panels.cornerRadius)
                .fill(.ultraThinMaterial)
        )
    }
}
