import SwiftUI

struct SettingsView: View {
    @Environment(SettingsManager.self) private var settings
    @State private var selectedCategory: SettingsCategory? = .general

    var body: some View {
        NavigationSplitView {
            List(SettingsCategory.allCases, selection: $selectedCategory) { category in
                NavigationLink(value: category) {
                    Label(category.rawValue, systemImage: category.icon)
                }
            }

        } detail: {
            if let category = selectedCategory {
                VStack(alignment: .leading, spacing: 0) {
                    switch category {
                    case .general: GeneralSettingsView(settings: settings)
                    case .appearance: ApperanceSettingsView(settings: settings)
                    case .shortcuts: GeneralSettingsView(settings: settings)
                    }
                }
                .background(Color(NSColor.windowBackgroundColor))
            }
        }
    }
}
