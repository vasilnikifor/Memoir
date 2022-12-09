import UIKit

protocol CalendarDelegate: AnyObject {
    func update()
}

protocol CalendarCoordinatorProtocol: AnyObject {
    func showMonthRecords(month: Date, delegate: CalendarDelegate?)
    func showDayRecords(date: Date, day: Day?, delegate: CalendarDelegate?)
    func showDayNote(date: Date, note: NoteRecord?, delegate: CalendarDelegate?)
    func showDayRate(date: Date, rate: DayRate?, delegate: CalendarDelegate?)
}

protocol CalendarPresenterProtocol: AnyObject {
    func viewLoaded()
}

final class CalendarPresenter {
    private weak var view: CalendarViewControllerProtocol?
    private weak var coordinator: CalendarCoordinatorProtocol?
    private let analyticsService: AnalyticsServiceProtocol
    private let dayService: DayServiceProtocol
    private let factory: CalendarFactoryProtocol
    
    init(
        view: CalendarViewControllerProtocol,
        coordinator: CalendarCoordinatorProtocol,
        dayService: DayServiceProtocol,
        analyticsService: AnalyticsServiceProtocol,
        factory: CalendarFactoryProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
        self.dayService = dayService
        self.analyticsService = analyticsService
        self.factory = factory
    }

    @objc
    private func timeChanged() {
        update()
    }
}

extension CalendarPresenter: CalendarPresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(calendarModel: CalendarViewModel(month: Date(), delegate: self))
        update()
        NotificationCenter.default.addObserver(self, selector: #selector(timeChanged), name: UIApplication.significantTimeChangeNotification, object: nil)
    }
}

extension CalendarPresenter: CalendarViewDelegate {
    func getMonthsWeekDays() -> [CalendarWeekdayViewModel] {
        return factory.makeWeekdays()
    }
    
    func getMonthsDays(month: Date) -> [CalendarDayViewModel] {
        return factory.makeCalendar(month: month, delegate: self)
    }
    
    func monthSelected(month: Date) {
        coordinator?.showMonthRecords(month: month, delegate: self)
    }

    func addNote(to date: Date) {
        coordinator?.showDayNote(date: date, note: nil, delegate: self)
    }
}

extension CalendarPresenter: CalendarFactoryDelegate {
    func dateSelected(_ date: Date, day: Day?) {
        coordinator?.showDayRecords(date: date, day: day, delegate: self)
    }

    func dateRated(_ date: Date, rate: DayRate?) {
        dayService.rateDay(of: date, rate: rate)
        update()
    }

    func rateDay(_ date: Date, rate: DayRate?) {
        coordinator?.showDayRate(date: date, rate: rate, delegate: self)
    }
}

extension CalendarPresenter: CalendarDelegate {
    func update() {
        view?.update(
            yesterdayConsoleModel: factory.makeYesterdayConsole(delegate: self),
            todaysConsoleModel: factory.makeTodayConsole(delegate: self)
        )
    }
}
