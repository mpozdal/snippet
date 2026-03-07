import SwiftData
import SwiftUI

struct CodeCardView: View {
    let codeSnippet: CodeSnippet
    
    private let codeFormatter = CodeFormatter()
    
    @Environment(\.modelContext) private var modelContext
    
    private var highlightedCode: AttributedString {
        codeFormatter.getHighlightedCode(text: codeSnippet.code, theme: codeSnippet.theme, language: nil)
    }
    
    private var themeBackground: Color {
        return codeFormatter.getThemeBackgroundColor(theme: codeSnippet.theme)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            codeWindowHeader
            
            ScrollView {
                Text(highlightedCode)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .background(RoundedRectangle(cornerRadius: 10).fill(themeBackground))
        .transition(.scale(scale: 0.8).combined(with: .opacity))
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
            
            if let appUrl = NSWorkspace.shared.urlForApplication(withBundleIdentifier: codeSnippet.sourceApp.bundleId) {
                let icon = NSWorkspace.shared.icon(forFile: appUrl.path)
                Image(nsImage: icon)
                    .resizable()
                    .frame(width: 16, height: 16)
                
                Text(codeSnippet.sourceApp.name)
                    .textCase(.lowercase)
                    .foregroundStyle(.gray)
                    .font(.system(size: 11))
            }
            
            Spacer()

            Menu(content: {
                Button(action: {}) {
                    Label("Edit", systemImage: "pencil")
                }
                Button(action: {
                    copyPrettyCodePNGToClipboard(highlightedCode, fontSize: codeSnippet.fontSize, outerBackground: NSColor(hex: codeSnippet.backgroundColorHex) ?? .black, editorBackground: NSColor(themeBackground))
                }) {
                    Label("Copy as image", systemImage: "document.on.document")
                }
                Button(action: {}) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                Divider()
                Button(role: .destructive, action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        modelContext.delete(codeSnippet)
                    }
                }) { Label("Remove snippet", systemImage: "trash")
                }
            }, label: {
                Image(systemName: "list.dash")
            })
            .buttonStyle(.borderless)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(.black.opacity(0.4))
        )
    }
}
