import SwiftUI

struct SnippetCountView: View {
    var count: Int

    var body: some View {
        Text(String(count))
            .font(.system(size: 10, weight: .bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(Color.blue.opacity(0.2))
            .foregroundColor(.blue)
            .clipShape(Capsule())
    }
}
