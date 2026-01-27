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
    
    func conver(to format: Date.Style, locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate(format.rawValue)
        return dateFormatter.string(from: self)
    }
}


extension Date {
    enum Style: String {
        case MMMd = "MMM d" // "Jan 22"
    }
}
