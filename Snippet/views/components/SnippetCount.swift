import SwiftUI

struct SnippetCountView: View {
    private var count: Int = 128
    
    var body: some View {
        Text(String(128))
            .font(.system(size: 10, weight: .bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(Color.blue.opacity(0.2))
            .foregroundColor(.blue)
            .clipShape(Capsule())
    }
}
