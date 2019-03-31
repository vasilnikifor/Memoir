import Foundation

extension Date {
    func firstDayOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .timeZone], from: Calendar.current.startOfDay(for: self))
        components.timeZone = TimeZone(secondsFromGMT: 0)
        return Calendar.current.date(from: components)!.getStartDay()
    }
    
    func lastDayOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.firstDayOfMonth())!.getStartDay()
    }
    
    func addDays(_ numberOfDays: Int) -> Date {
        return Date(timeInterval: TimeInterval(numberOfDays*86400), since: self)
    }
    
    func addMonths(_ numberOfMonths: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)!
    }
    
    func getStartDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}
