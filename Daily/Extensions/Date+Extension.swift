import Foundation

extension Date {
    init(year: Int, month: Int, day: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        self = Date.calendar.date(from: dateComponents) ?? Date()
    }
}

extension Date {
    static var calendar: Calendar {
        var calendar = Calendar.current
        calendar.locale = Locale.currentLocale.locale
        return calendar
    }
}

extension Date {
    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.currentLocale.locale
        return dateFormatter
    }()

    private var calendar: Calendar {
        Date.calendar
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
        return calendar
            .date(from: calendar.dateComponents([.year, .month, .timeZone], from: self.startOfDay))!
            .startOfDay
    }

    var firstDayOfYear: Date {
        return calendar
            .date(from: calendar.dateComponents([.year, .timeZone], from: self.startOfDay))!
            .startOfDay
    }

    var lastDayOfMonth: Date {
        return calendar
            .date(byAdding: DateComponents(month: 1, day: -1), to: self.firstDayOfMonth)!
            .startOfDay
    }

    var lastDayOfYear: Date {
        return calendar
            .date(byAdding: DateComponents(month: 12, day: -1), to: self.firstDayOfYear)!
            .startOfDay
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

    var year: Int {
        let components = calendar.dateComponents([.year], from: self)
        return components.year ?? .zero
    }

    var dateNumber: String {
        return String(calendar.component(.day, from: self))
    }

    /// "h:mm a"
    var timeRepresentation: String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }

    /// "EE, MMM d"
    var dateRepresentation: String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: self)
    }

    /// "EE, d"
    var dateShortRepresentation: String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = "EE, d"
        return dateFormatter.string(from: self)
    }

    /// "MMMM yyyy"
    var monthRepresentation: String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }

    /// "yyyy"
    var yearRepresentation: String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }

    func addDays(_ numberOfDays: Int) -> Date {
        return calendar.date(byAdding: .day, value: numberOfDays, to: self)!
    }

    func addMonths(_ numberOfMonths: Int) -> Date {
        return calendar.date(byAdding: .month, value: numberOfMonths, to: self)!
    }
}
