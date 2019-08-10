import Foundation

// MARK: - Conversion
extension Date {

    func firstDayOfMonth() -> Date {
        return Calendar
            .current
            .date(from: Calendar.current.dateComponents([.year, .month, .timeZone], from: self.getStartDay()))!
            .getStartDay()
    }
    
    func lastDayOfMonth() -> Date {
        return Calendar
            .current
            .date(byAdding: DateComponents(month: 1, day: -1), to: self.firstDayOfMonth())!
            .getStartDay()
    }
    
    func addDays(_ numberOfDays: Int) -> Date {
        return Calendar
            .current
            .date(byAdding: .day, value: numberOfDays, to: self)!
    }
    
    func addMonths(_ numberOfMonths: Int) -> Date {
        return Calendar
            .current
            .date(byAdding: .month, value: numberOfMonths, to: self)!
    }
    
    func getStartDay() -> Date {
        return Calendar
            .current
            .startOfDay(for: self)
    }
    
    func getTime() -> Date {
        return Calendar
            .current
            .date(from: Calendar.current.dateComponents([.hour, .minute, .second, .timeZone], from: self))!
    }

}

// MARK: - Presentation
extension Date {
    
    func getTimeRepresentation() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
    func getDateNumber() -> String {
        return String(Calendar.current.component(.day, from: self))
    }
    
}
