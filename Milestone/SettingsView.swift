import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section("General") {
                Toggle("Enable Notifications", isOn: .constant(true))
                Toggle("Use Metric Units", isOn: .constant(true))
            }
        }
    }
}

#Preview {
    NavigationStack { SettingsView() }
}
