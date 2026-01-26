//
//  GoalContainerMock.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 26.01.2026.
//

import SwiftUI
import SwiftData


enum GoalContainerMock {
    static let previewContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: GoalModel.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            for goal in Self.goals {
                container.mainContext.insert(goal)
            }
            return container
        } catch {
            fatalError("Failed to create container")
        }
    }()
    
    private static var goals: [GoalModel] {
        [
            .init(id: UUID(), name: "Goal First", steps: [
                .init(id: UUID(), title: "Step 1", isCompleted: false, date: Date()),
                .init(id: UUID(), title: "Step 2", isCompleted: true, date: Date()),
                .init(id: UUID(), title: "Step 3", isCompleted: true, date: Date())
            ]),
            .init(id: UUID(), name: "Lose Weight", steps: [
                .init(id: UUID(), title: "Go to gym", isCompleted: false, date: Date()),
                .init(id: UUID(), title: "Go to gym on Monday", isCompleted: true, date: Date()),
                .init(id: UUID(), title: "Go to gym on Suterday", isCompleted: true, date: Date())
            ]),
            .init(id: UUID(), name: "T4 grade", steps: [
                .init(id: UUID(), title: "Path T3-T4 learning path until 2026, also receive a salary raise as well", isCompleted: false, date: Date()),
                .init(id: UUID(), title: "Pass exam", isCompleted: true, date: Date()),
                .init(id: UUID(), title: "Update documents", isCompleted: false, date: Date())
            ])
        ]
    }
}
