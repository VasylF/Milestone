import SwiftUI

struct SettingsView: View {
    private var appVersion: String {
        let version = Bundle.version ?? ""
        let build = Bundle.build ?? ""
        return "\(version) (\(build))"
    }
    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderView(
                screenName: Strings.title,
                subtitle: Strings.subtitle
            )
            VStack(alignment: .leading) {
                SettingRowHeader(text: Strings.about)
                SettingRow(icon: .minof, title: Strings.version, value: appVersion)
                Spacer()
            }
            .padding(.horizontal, GlobalConstants.hPadding)
            .padding(.top, Constants.topPadding)
        }
        .background(.softGray)
    }
}

// MARK: - Strings
private enum Strings {
    static let title: String = "Settings"
    static let subtitle: String = "Manage your preferences"
    static let version: String = "Version"
    static let about: String = "About"
}

// MARK: - Constants
private enum Constants {
    static let topPadding: CGFloat = 24
}

// MARK: - Preview
#Preview {
    NavigationStack { SettingsView() }
}
