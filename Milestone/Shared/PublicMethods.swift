//
//  PublicMethods.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 07.02.2026.
//

import UIKit

func convertToDateViewState(_ date: Date?) -> DateViewState {
    guard let date else {
        return .noDate
    }
    
    if date.isToday {
        return .today
    } else if date.isOverdueByDay {
        return .overdue
    } else {
        return .date(date)
    }
}

func triggerCompletionHaptics(curentState: Bool) {
    if curentState {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    } else {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
