import Foundation

protocol CalendarFactoryDelegate: AnyObject {
    func dateSelected(_ date: Date)
}

protocol CalendarFactoryProtocol: AnyObject {
    func make() -> [CalendarWeekdayViewModel]
    func make(month: Date, delegate: CalendarFactoryDelegate) -> [CalendarDayViewModel]
}

final class CalendarFactory: CalendarFactoryProtocol {
    private let recordsService: RecordsServiceProtocol
    
    init(recordsService: RecordsServiceProtocol) {
        self.recordsService = recordsService
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
        
        while processingDate <= lastCalendarDate {
            if processingDate < firstMonthDate || processingDate > lastMonthDate {
                calendarDays.append(
                    CalendarDayViewModel(
                        date: processingDate,
                        isToday: processingDate == todayDate,
                        state: .unactive,
                        action: nil
                    )
                )
            } else {
                if true {
                    calendarDays.append(
                        CalendarDayViewModel(
                            date: processingDate,
                            isToday: processingDate == todayDate,
                            state: .empty,
                            action: { [weak delegate] in delegate?.dateSelected(processingDate) }
                        )
                    )
                } else {
                    // TODO: -
                    let dayRate: DayRate?
                    let randomRate = Int.random(in: 0...3)
                    if randomRate == 0 {
                        dayRate = .none
                    } else if randomRate == 1 {
                        dayRate = .bad
                    } else if randomRate == 2 {
                        dayRate = .average
                    } else {
                        dayRate = .good
                    }
                    
                    calendarDays.append(
                        CalendarDayViewModel(
                            date: processingDate,
                            isToday: processingDate == todayDate,
                            state: .filled(dayRate: dayRate),
                            action: { [weak delegate] in delegate?.dateSelected(processingDate) }
                        )
                    )
                }

            }
            processingDate = processingDate.addDays(1)
        }

        
        return calendarDays
    }
}

