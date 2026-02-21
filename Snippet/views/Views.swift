import SwiftUI

struct MenuPopupView: View {
    var body: some View {
        VStack {}
            .padding()
            .frame(width: Constants.Panels.mainWidth, height: Constants.Panels.mainHeight)
            .background(
                RoundedRectangle(cornerRadius: Constants.Panels.cornerRadius)
                    .fill(.ultraThinMaterial)
            )
    }
}

struct BottomBarView: View {
    var body: some View {
        HStack {
            Text("Preferences")
            Spacer()
            Text("Quit")
        }
        .padding()
        .frame(width: Constants.Panels.bottomWidth, height: Constants.Panels.bottomHeight)
        .background(
            RoundedRectangle(cornerRadius: Constants.Panels.cornerRadius)
                .fill(.ultraThinMaterial)
        )
    }
}
