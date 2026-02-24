import AppKit
import SwiftUI

struct MenuPopupView: View {
    let manager: ClipboardManager

    @Environment(CodeFormatter.self) private var formatter

    var body: some View {
        let highlighted = formatter.getHighlightedCode(text: manager.lastCopiedText, language: nil)

        return VStack(spacing: 0) {
            header

            ScrollView {
                CodeCardView(highlighted: highlighted)
                    .shadow(color: .black.opacity(0.3), radius: 10, y: 5)

                CodeCardView(highlighted: highlighted)
                    .shadow(color: .black.opacity(0.3), radius: 10, y: 5)

                CodeCardView(highlighted: highlighted)
                    .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
            }

            Spacer()

            footer
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .frame(width: Constants.Panels.mainWidth, height: Constants.Panels.mainHeight)
        .background(
            RoundedRectangle(cornerRadius: Constants.Panels.cornerRadius)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.Panels.cornerRadius)
                        .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                )
        )
    }

    private var header: some View {
        HStack {
            Label("Recent Snippets", systemImage: "curlybraces")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private var footer: some View {
        VStack(spacing: 12) {
            Divider()

            Button(action: { print("Explore clicked") }) {
                HStack {
                    Spacer()

                    SnippetCountView()

                    Text("Explore all snippets")

                    Image(systemName: "chevron.right")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .buttonStyle(.borderless)
        }
    }
}
