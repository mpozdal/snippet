import AppKit
import SwiftData
import SwiftUI

struct MenuPopupView: View {
    @Query(sort: \CodeSnippet.timestamp, order: .reverse) var snippets: [CodeSnippet]

    var body: some View {
        VStack(spacing: 0) {
            if let latest = snippets.first {
                header

                CodeCardView(codeSnippet: latest)
                    .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
                    .animation(.default, value: snippets)

                footer
                    .padding()
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
            Label("Recent Snippet", systemImage: "curlybraces")
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

                    SnippetCountView(count: snippets.count)

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
