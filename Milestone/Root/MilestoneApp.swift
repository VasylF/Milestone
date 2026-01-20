//
//  MilestoneApp.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 17.01.2026.
//

import SwiftUI
import SwiftData

@main
struct MilestoneApp: App {

    var body: some Scene {
        WindowGroup {
            RootTabView()
        }
        .modelContainer(for: GoalModel.self)
    }
}
