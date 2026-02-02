//
//  AssetImage.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 31.01.2026.
//

import SwiftUI

struct RootTabView: View {
    @State private var selection: Tab = .goals

    var body: some View {
        TabView(selection: $selection) {
            goalsTab()
            stepsTab()
            settingsTab()
        }
        .toolbarColorScheme(.dark, for: .tabBar)
    }
    
    // MARK: - Tabs
    private func goalsTab() -> some View {
        let tab = Tab.goals
        return NavigationStack {
            GoalsView()
        }
        .tabItem {
            Image(selection == tab ? .goalSelected : .goal)
        }
        .tag(tab)
    }

    private func stepsTab() -> some View {
        let tab = Tab.steps
        return NavigationStack {
            StepsView()
        }
        .tabItem {
            Image(selection == tab ? .stepSelected : .step)
        }
        .tag(tab)
    }

    private func settingsTab() -> some View {
        let tab = Tab.settings
        return NavigationStack {
            SettingsView()
        }
        .tabItem {
            Image(selection == tab ? .settingsSelected : .settings)
        }
        .tag(tab)
    }
}

// MARK: - Tab
private extension RootTabView {
    enum Tab: String, Hashable {
        case goals
        case steps
        case settings
    }
}

// MARK: - String Constants
private extension RootTabView {
    enum Constants {
        static let tapSpacing: CGFloat = 4
    }
}

// MARK: - Preview
#Preview {
    RootTabView()
}
