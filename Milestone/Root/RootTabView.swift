import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                GoalsView()
                    .navigationTitle("Goals")
            }
            .tabItem {
                Image(systemName: "target")
                Text("Goals")
            }

            NavigationStack {
                TodaysStepsView()
                    .navigationTitle("Today")
            }
            .tabItem {
                Image(systemName: "figure.walk")
                Text("Today")
            }

            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
    }
}

#Preview {
    RootTabView()
}
