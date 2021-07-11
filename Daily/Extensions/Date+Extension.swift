import Foundation

// MARK: - Static
extension Date {
    private static var calendar: Calendar {
        return Calendar.current
    }

    static var shortWeekdaySymbols: [String] {
        let shortWeekdaySymbols = calendar.shortWeekdaySymbols
        let firstWeekdayIndex = calendar.firstWeekday - 1
        let lastWeekdayIndex = shortWeekdaySymbols.count - 1
        let weekdays: [String] = Array(shortWeekdaySymbols[firstWeekdayIndex...lastWeekdayIndex] + shortWeekdaySymbols[0..<firstWeekdayIndex])
        return weekdays.map { $0.capitalizedFirstLetter }
    }
}


// MARK: - Instance
extension Date {
    private var calendar: Calendar {
        return Date.calendar
    }
    
    var firstMonthCalendarDate: Date {
        let firstDayOfMonth = firstDayOfMonth
        let absoluteDelta = calendar.component(.weekday, from: firstDayOfMonth) - calendar.firstWeekday
        let delta = absoluteDelta < 0 ? calendar.shortWeekdaySymbols.count + absoluteDelta : absoluteDelta
        return firstDayOfMonth.addDays(-delta)
    }
    
    var lastMonthCalendarDate: Date {
        let lastDayOfMonth = lastDayOfMonth
        let weekdaysCount = calendar.shortWeekdaySymbols.count
        let absoluteLastWeekday = calendar.firstWeekday - 1
        let lastWeekday = absoluteLastWeekday < 1 ? weekdaysCount - absoluteLastWeekday : absoluteLastWeekday
        let absoluteDelta = lastWeekday - calendar.component(.weekday, from: lastDayOfMonth)
        let delta = absoluteDelta < 0 ? weekdaysCount + absoluteDelta : absoluteDelta
        return lastDayOfMonth.addDays(delta)
    }
    
    var firstDayOfMonth: Date {
        return calendar.date(from: calendar.dateComponents([.year, .month, .timeZone], from: self.startOfDay))!.startOfDay
    }
    
    var lastDayOfMonth: Date {
        return calendar.date(byAdding: DateComponents(month: 1, day: -1), to: self.firstDayOfMonth)!.startOfDay
    }
    
    var startOfDay: Date {
        return calendar.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfDay)!
    }
    
    var time: Date {
        return calendar.date(from: calendar.dateComponents([.hour, .minute, .second, .timeZone], from: self))!
    }
    
    var dateNumber: String {
        return String(calendar.component(.day, from: self))
    }
    
    /// "h:mm a"
    var timeRepresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
    /// "EE, MMM d"
    var dateRepresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: self)
    }
    
    /// "MMMM yyyy"
    var monthRepresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func addDays(_ numberOfDays: Int) -> Date {
        return calendar.date(byAdding: .day, value: numberOfDays, to: self)!
    }
    
    func addMonths(_ numberOfMonths: Int) -> Date {
        return calendar.date(byAdding: .month, value: numberOfMonths, to: self)!
    }
}
