//
//  Date.swift
//  Milestone
//
//  Created by Vasyl Fuchenko on 24.01.2026.
//

import Foundation


extension Date {
    private var currentCalendar: Calendar {
        Calendar.current
    }
    
    func toRelativeDate() -> String {
        if currentCalendar.isDateInToday(self) { return "Today" }
        if currentCalendar.isDateInTomorrow(self) { return "Tomorrow" }
        if currentCalendar.isDateInYesterday(self) { return "Yesterday" }
        
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = true
        formatter.timeStyle = .none
        formatter.setLocalizedDateFormatFromTemplate("MMMd")
        return formatter.string(from: self)
    }
    
    var isToday: Bool {
        currentCalendar.isDateInToday(self)
    }
    
    var isOverdueByDay: Bool {
        self < currentCalendar.startOfDay(for: Date())
    }
    
    var isUpcomingByDay: Bool {
        // Upcoming if today or in the future (by day semantics)
        !currentCalendar.isDate(self, inSameDayAs: currentCalendar.startOfDay(for: Date())) && self >= currentCalendar.startOfDay(for: Date()) || currentCalendar.isDateInToday(self)
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
