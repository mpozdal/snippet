import AppKit
import SwiftData
import SwiftUI

struct MenuPopupView: View {
    @Query(sort: \CodeSnippet.timestamp, order: .reverse) var snippets: [CodeSnippet]
    @State private var currentIndex: Int = 0

    private var selectedSnippet: CodeSnippet? {
        guard !snippets.isEmpty else { return nil }

        let safeIndex = snippets.indices.contains(currentIndex) ? currentIndex : 0

        return snippets[safeIndex]
    }

    var body: some View {
        VStack(spacing: 0) {
            if let selected = selectedSnippet {
                header

                CodeCardView(codeSnippet: selected)
                    .id(selected.id)
                    .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
                    .animation(.default, value: snippets)
                    .padding(.bottom)

                Divider().padding(.horizontal, 18)

                footer

            } else {
                ContentUnavailableView("No Snippets", systemImage: "curlybraces", description: Text("Copy some code to see it here."))
                    .frame(maxHeight: .infinity)
            }
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
            Label("Snippet", systemImage: "curlybraces")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
    }

    private var footer: some View {
        HStack {
            HStack(spacing: 8) {
                navigationButton(systemImage: "chevron.left", enabled: currentIndex < snippets.count - 1) {
                    withAnimation { currentIndex += 1 }
                }
                navigationButton(systemImage: "chevron.right", enabled: currentIndex > 0) {
                    withAnimation { currentIndex -= 1 }
                }
            }

            Spacer()

            Button(action: { print("Explore clicked") }) {
                HStack {
                    SnippetCountView(count: snippets.count)

                    Text("Explore all snippets")

                    Image(systemName: "chevron.right")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            .buttonStyle(.borderless)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
    }
}

private func navigationButton(systemImage: String, enabled: Bool, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Image(systemName: systemImage)
            .font(.system(size: 12, weight: .bold))
            .frame(width: 28, height: 28)
            .background(RoundedRectangle(cornerRadius: 8).fill(.white.opacity(enabled ? 0.1 : 0.03)))
            .foregroundColor(enabled ? .primary : .secondary.opacity(0.3))
    }
    .buttonStyle(.plain)
    .disabled(!enabled)
}
