import Foundation

protocol CalendarFactoryDelegate: AnyObject {
    func dateSelected(_ date: Date, day: Day?)
}

protocol CalendarFactoryProtocol: AnyObject {
    func make() -> [CalendarWeekdayViewModel]
    func make(month: Date, delegate: CalendarFactoryDelegate) -> [CalendarDayViewModel]
}

final class CalendarFactory: CalendarFactoryProtocol {
    private let dayService: DayServiceProtocol
    
    init(dayService: DayServiceProtocol) {
        self.dayService = dayService
    }
    
    func make() -> [CalendarWeekdayViewModel] {
        return Date.shortWeekdaySymbols.map {
            CalendarWeekdayViewModel(text: $0)
        }
    }
    
    func make(month: Date, delegate: CalendarFactoryDelegate) -> [CalendarDayViewModel] {
        var calendarDays: [CalendarDayViewModel] = []
        var processingDate = month.firstMonthCalendarDate.startOfDay
        let firstMonthDate = month.firstDayOfMonth.startOfDay
        let lastMonthDate = month.lastDayOfMonth.startOfDay
        let lastCalendarDate = month.lastMonthCalendarDate.startOfDay
        let todayDate = Date().startOfDay
        let days = dayService.getDays(of: month)
        
        while processingDate <= lastCalendarDate {
            if processingDate < firstMonthDate || processingDate > lastMonthDate {
                calendarDays.append(
                    CalendarDayViewModel(
                        date: processingDate,
                        isToday: processingDate == todayDate,
                        state: .inactive,
                        action: nil
                    )
                )
            } else {
                let day = days.first(where: { $0.date?.startOfDay == processingDate })
                calendarDays.append(
                    CalendarDayViewModel(
                        date: processingDate,
                        isToday: processingDate == todayDate,
                        state: (day?.isEmpty ?? true) ? .empty : .filled(dayRate: day?.rate),
                        action: { [processingDate, weak day, weak delegate] in delegate?.dateSelected(processingDate, day: day) }
                    )
                )
            }
            processingDate = processingDate.addDays(1)
        }

        return calendarDays
    }
}

