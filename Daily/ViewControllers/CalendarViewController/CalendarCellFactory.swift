import UIKit

enum CalendarCellTypes {
    case inactiveDay(CalendarInactiveDayViewModel)
    case activeDay(CalendarActiveDayViewModel)
}

final class CalendarCellFactory {
    static func configure(month: Date) -> [CalendarCellTypes] {
        var cells: [CalendarCellTypes] = []
        
        let daysOfMonth = DAODayService.getAllDaysOfMounth(month)
        var processingDate = month.firstMonthCalendarDate.startOfDay
        let lastCalendarDate = month.lastMonthCalendarDate.startOfDay
        let todayDate = Date().startOfDay
        
        while processingDate <= lastCalendarDate {
            if processingDate.firstDayOfMonth == month.firstDayOfMonth {
                let day = getDay(daysOfMonth: daysOfMonth, date: processingDate)
                let dayColor = (day?.isEmpty ?? true) ? .clear : Theme.getRateColor(day?.rate)
                let viewModel = CalendarActiveDayViewModel(date: processingDate,
                                                           dayColor: dayColor,
                                                           isHighlited: processingDate == todayDate)
                cells.append(.activeDay(viewModel))
            } else {
                cells.append(.inactiveDay(CalendarInactiveDayViewModel(date: processingDate)))
            }
            processingDate = processingDate.addDays(1)
        }
        
        return cells
    }
}

// MARK: - Private methods
extension CalendarCellFactory {
    private static func getDay(daysOfMonth: [Day], date: Date) -> Day? {
        for index in daysOfMonth.indices {
            if daysOfMonth[index].date == date.startOfDay {
                return daysOfMonth[index]
            }
        }
        return nil
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
