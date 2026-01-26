import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
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


// MARK: - Preview
#Preview {
    NavigationStack { SettingsView() }
}
