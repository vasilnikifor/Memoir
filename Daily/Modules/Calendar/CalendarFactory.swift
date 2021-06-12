import Foundation

protocol CalendarFactoryProtocol: AnyObject {
    func make() -> [CalendarWeekdayViewModel]
    func make(month: Date) -> [CalendarDayViewModel]
}

final class CalendarFactory: CalendarFactoryProtocol {
    func make() -> [CalendarWeekdayViewModel] {
        return Date.shortWeekdaySymbols.map {
            CalendarWeekdayViewModel(text: $0)
        }
    }
    
    func make(month: Date) -> [CalendarDayViewModel] {
        return []
    }
}

