import SwiftUI

struct CodeCardView: View {
    let highlighted: AttributedString

    @State private var isHovered = false

    var body: some View {
        VStack(spacing: 0) {
            codeWindowHeader
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .padding(.horizontal, 18)
    }

    private var codeWindowHeader: some View {
        HStack(spacing: 6) {
            HStack(spacing: 6) {
                Circle().fill(Color.red.opacity(0.5)).frame(width: 8, height: 8)
                Circle().fill(Color.yellow.opacity(0.5)).frame(width: 8, height: 8)
                Circle().fill(Color.green.opacity(0.5)).frame(width: 8, height: 8)
            }

            Spacer()

            Text(isHovered ? "24.02.2026 13:33" : "Swift")
                .font(.system(size: 12, weight: .medium, design: .monospaced))
                .foregroundStyle(.gray)
                .animation(.smooth(duration: 0.5), value: isHovered)

            Button {} label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white.opacity(0.5))
            }
            .buttonStyle(.borderless)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.2))
        .contentShape(Rectangle())
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
