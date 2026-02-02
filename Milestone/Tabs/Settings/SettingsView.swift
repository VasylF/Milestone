import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderView(
                screenName: Strings.title,
                subtitle: Strings.subtitle
            )
            Form {
                Section("General") {
                    Toggle("Enable Notifications", isOn: .constant(true))
                    Toggle("Use Metric Units", isOn: .constant(true))
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            appVersionView
                .frame(maxWidth: .infinity)
                .background(.clear)
        }
    }
    
    private var appVersionView: some View {
        let version = Bundle.version ?? ""
        let build = Bundle.build ?? ""
        return Text("Version \(version) (\(build))")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.bottom, 15)
    }
}

// MARK: - Constants
private enum Strings {
    static let title: String = "Settings"
    static let subtitle: String = "Manage your preferences"
}

// MARK: - Preview
#Preview {
    NavigationStack { SettingsView() }
}
