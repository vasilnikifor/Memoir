import Foundation

extension Date {
    private static var firstWeekday: Int {
        return 2
    }
    
    static var shortWeekdaySymbols: [String] {
        let shortWeekdaySymbols = Date().calendar.shortWeekdaySymbols
        let firstWeekdayIndex = firstWeekday - 1
        let lastWeekdayIndex = shortWeekdaySymbols.count - 1
        let shortWeekdaySymbolsWithNeededFirstWeekday: [String] =
            Array(
                shortWeekdaySymbols[firstWeekdayIndex...lastWeekdayIndex] + shortWeekdaySymbols[0..<firstWeekdayIndex]
            )
        return shortWeekdaySymbolsWithNeededFirstWeekday.map { $0.capitalizedFirstLetter }
    }
}

extension Date {
    var firstMonthCalendarDate: Date {
        let firstDayOfMonth = firstDayOfMonth
        let deltaFromFirstMonthDate = calendar.component(.weekday, from: firstDayOfMonth) - 1
        return firstDayOfMonth.addDays(-deltaFromFirstMonthDate)
    }
    
    var lastMonthCalendarDate: Date {
        let lastDayOfMonth = lastDayOfMonth
        let deltaFromLastMonthDate = calendar.shortWeekdaySymbols.count - calendar.component(.weekday, from: lastDayOfMonth)
        return lastDayOfMonth.addDays(deltaFromLastMonthDate)
    }
    
    private var locale: Locale {
        return Locale(identifier: "en_EN")
    }
    
    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.locale = locale
        return calendar
    }
    
    var firstDayOfMonth: Date {
        return calendar
            .date(from: calendar.dateComponents([.year, .month, .timeZone], from: self.startOfDay))!
            .startOfDay
    }
    
    var lastDayOfMonth: Date {
        return calendar
            .date(byAdding: DateComponents(month: 1, day: -1), to: self.firstDayOfMonth)!
            .startOfDay
    }
    
    var startOfDay: Date {
        return calendar.startOfDay(for: self)
    }
    
    var time: Date {
        return calendar.date(from: calendar.dateComponents([.hour, .minute, .second, .timeZone], from: self))!
    }
    
    var timeRepresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
    /// "EE, MMM d"
    var dateRepresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: self)
    }
    
    /// "MMMM yyyy"
    var monthRepresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    var dateNumber: String {
        return String(calendar.component(.day, from: self))
    }
    
    func addDays(_ numberOfDays: Int) -> Date {
        return calendar.date(byAdding: .day, value: numberOfDays, to: self)!
    }
    
    func addMonths(_ numberOfMonths: Int) -> Date {
        return calendar.date(byAdding: .month, value: numberOfMonths, to: self)!
    }
    

}
