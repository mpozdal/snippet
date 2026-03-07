import SwiftUI

func SettingRow<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
    HStack {
        Text(title)
            .font(.system(size: 13))
        Spacer()
        content()
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 12)
    .background(
        RoundedRectangle(cornerRadius: 12)
            .fill(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.05), lineWidth: 1)
            )
    )
}

func Combo(selected: Binding<String>, list: [String]) -> some View {
    Picker("", selection: selected) {
        ForEach(list, id: \.self) { item in
            Text(formatThemeName(text: item))
                .tag(item)
        }
    }
    .pickerStyle(.menu)
}
