import Foundation

enum CalendarCellTypes {
    case inactiveDay(CalendarInactiveDayViewModel)
    case activeDay(CalendarActiveDayViewModel)
}

final class CalendarCellFactory {
    static func configure(month: Date) -> [CalendarCellTypes] {
        var cells: [CalendarCellTypes] = []
        
        var processingDate = month.firstMonthCalendarDate.startOfDay
        let lastCalendarDate = month.lastMonthCalendarDate.startOfDay
        
        while processingDate <= lastCalendarDate {
            if processingDate.firstDayOfMonth == month.firstDayOfMonth {
                cells.append(.activeDay(CalendarActiveDayViewModel(date: processingDate)))
            } else {
                cells.append(.inactiveDay(CalendarInactiveDayViewModel(date: processingDate)))
            }
            processingDate = processingDate.addDays(1)
        }
//        let daysOfMonth = DAODayService.getAllDaysOfMounth(month)
//        let firstDayOfMonth = month.firstDayOfMonth
//
//        firstDayOfMonth.addDays(-(Calendar.current.component(.weekday, from: firstDayOfMonth)-1)).startOfDay
        
        return cells
    }
}

extension Date {
    var firstMonthCalendarDate: Date {
        let firstDayOfMonth = self.firstDayOfMonth
        let deltaFromFirstMonthDate = calendar.component(.weekday, from: firstDayOfMonth) - 1
        return firstDayOfMonth.addDays(-deltaFromFirstMonthDate)
    }
    
    var lastMonthCalendarDate: Date {
        let lastDayOfMonth = self.lastDayOfMonth
        let deltaFromLastMonthDate = calendar.shortWeekdaySymbols.count - calendar.component(.weekday, from: lastDayOfMonth)
        return lastDayOfMonth.addDays(deltaFromLastMonthDate)
    }
}
