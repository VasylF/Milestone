//
//  StepModel.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 20.01.2026.
//

import SwiftData
import Foundation

@Model
final class StepModel {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var date: Date?
    var createdAt: Date = Date()
    var goalName: String?
    var hasGoal: Bool {
        goalName != nil
    }
    
    init(id: UUID, title: String, isCompleted: Bool, date: Date?, goalName: String? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.date = date
        self.goalName = goalName
    }
}

