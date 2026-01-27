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
            }

            NavigationStack {
                TodaysStepsView()
                    .navigationTitle("To Do List")
            }
            .tabItem {
                Image(systemName: "figure.walk")
            }

            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gearshape")
            }
        }
    }
}

#Preview {
    RootTabView()
}
