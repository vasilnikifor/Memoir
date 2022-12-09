import UIKit

protocol CalendarPresenterProtocol: AnyObject {
    func viewLoaded()
}

protocol CalendarDelegate: AnyObject {
    func update()
}

final class CalendarPresenter {
    private weak var view: CalendarViewControllerProtocol?
    private let factory: CalendarFactoryProtocol
    private let dayService: DayServiceProtocol
    private let analyticsService: AnalyticsServiceProtocol
    
    init(
        view: CalendarViewControllerProtocol,
        factory: CalendarFactoryProtocol,
        dayService: DayServiceProtocol,
        analyticsService: AnalyticsServiceProtocol
    ) {
        self.view = view
        self.factory = factory
        self.dayService = dayService
        self.analyticsService = analyticsService
    }

    @objc
    private func timeChanged() {
        update()
    }
}

extension CalendarPresenter: CalendarPresenterProtocol {
    func viewLoaded() {
        var backgroundImage: UIImage?
        if Date().isNewYearTime {
            backgroundImage = UIImage(named: "christmas1")
        }

        view?.setupInitialState(
            calendarModel: CalendarViewModel(month: Date(), delegate: self),
            backgroundImage: backgroundImage
        )
        update()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(timeChanged),
            name: UIApplication.significantTimeChangeNotification,
            object: nil
        )
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
        let inputModel = MonthRecordsInputModel(month: month, delegate: self)
        let viewController = MonthRecordsAssembler.assemble(inputModel)
        view?.push(viewController)
    }

    func addNote(to date: Date) {
        let inputModel = DayNoteInputModel(date: date, note: nil, delegate: self)
        let viewController = DayNoteAssembler.assemble(inputModel)
        view?.present(viewController)
    }
}

extension CalendarPresenter: CalendarFactoryDelegate {
    func dateSelected(_ date: Date, day: Day?) {
        let inputModel = DayRecordsInputModel(date: date, day: day, delegate: self)
        let viewController = DayRecordsAssembler.assemble(inputModel)
        view?.push(viewController)
    }

    func dateRated(_ date: Date, rate: DayRate?) {
        dayService.rateDay(of: date, rate: rate)
        update()
    }

    func rateDay(_ date: Date, rate: DayRate?) {
        let inputModel = DayRateInputModel(date: date, selectedRate: rate, delegate: self)
        let viewController = DayRateAssembler.assemble(inputModel)
        view?.present(viewController)
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

extension Date {
    var isNewYearTime: Bool {
        let currentDate = Date()
        let currentDateYear = currentDate.year
        let minDate = Date(year: currentDateYear, month: 12, day: 17)
        let maxDate = Date(year: currentDateYear+1, month: 1, day: 7)
        return currentDate >= minDate && currentDate <= maxDate
    }
}
