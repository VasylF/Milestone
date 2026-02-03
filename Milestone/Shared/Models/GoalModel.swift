//
//  GoalModel.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 20.01.2026.
//

import Foundation
import SwiftData

@Model
final class GoalModel: Identifiable {
    var id: UUID
    var name: String
    @Relationship(deleteRule: .cascade) var steps: [StepModel]
    
    init(id: UUID, name: String, steps: [StepModel]) {
        self.id = id
        self.name = name
        self.steps = steps
    }
    
    var numberOfCompletedSteps: Int {
        steps.filter(\.isCompleted).count
    }
    
    var numberOfSteps: Int {
        steps.count
    }
    
    var isGoalCompleted: Bool {
        numberOfCompletedSteps == numberOfSteps
    }
}
