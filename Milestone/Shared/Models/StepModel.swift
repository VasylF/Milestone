//
//  StepModel.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 20.01.2026.
//

import SwiftData
import Foundation

@Model
class StepModel {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var date: Date
    
    init(id: UUID, title: String, isCompleted: Bool, date: Date) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.date = date
    }
}

