//
//  Date.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 24.01.2026.
//

import Foundation


extension Date {
    func toRelativeDate() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) { return "Today" }
        if calendar.isDateInTomorrow(self) { return "Tomorrow" }
        
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = true
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("MMMd")
        return formatter.string(from: self)
    }
}
