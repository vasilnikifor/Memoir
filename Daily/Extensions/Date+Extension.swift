import Foundation

extension Date {
    var calendar: Calendar {
        return Calendar.current
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
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
    var dateRepresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: self)
    }
    
    var monthRepresentation: String {
        let dateFormatter = DateFormatter()
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
