import Foundation

final class DayRateAssembler {
    static func assemble(date: Date, calendarDelegate: CalendarDelegate?) -> DayRateViewController {
        let viewContorller = DayRateViewController()
        let presenter = DayRatePresenter(view: viewContorller, calendarDelegate: calendarDelegate, date: date)
        viewContorller.presenter = presenter
        return viewContorller
    }
}
