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
    private let dayService: DayServiceProtocol
    private let cms: CmsProtocol
    private let factory: CalendarFactoryProtocol

    init(
        view: CalendarViewControllerProtocol,
        coordinator: CalendarCoordinatorProtocol,
        dayService: DayServiceProtocol,
        cms: CmsProtocol,
        factory: CalendarFactoryProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
        self.dayService = dayService
        self.cms = cms
        self.factory = factory
    }

    @objc
    private func timeChanged() {
        update()
    }
}

extension CalendarPresenter: CalendarPresenterProtocol {
    func viewLoaded() {
        var backgroundImage: UIImage?
        let todaysDate = Date()
        if todaysDate.isNewYearTime {
            backgroundImage = UIImage(named: "christmas")
        } else if todaysDate.isSpringDay {
            backgroundImage = UIImage(named: "spring")
        } else if todaysDate.isAugustDay {
            backgroundImage = UIImage(named: "august")
        } else if todaysDate.isCosmicDay {
            backgroundImage = UIImage(named: "cosmic")
        }

        view?.setupInitialState(
            calendarModel: CalendarViewConfiguration(
                month: todaysDate,
                isBackgroundBlurred: todaysDate.isWallpaperDay,
                previousMonthAccessibilityLabel: cms.calendar.previousMonth,
                nextMonthAccessibilityLabel: cms.calendar.nextMonth,
                delegate: self
            ),
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

    func getMonthsDays(month: Date) -> [CalendarDayViewConfiguration] {
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
            todaysConsoleModel: factory.makeTodayConsole(delegate: self),
            addNoteConsole: factory.makeNoteConsole(delegate: self)
        )
    }
}

extension Date {
    var isWallpaperDay: Bool {
        return isNewYearTime
            || isSpringDay
            || isAugustDay
            || isCosmicDay
    }

    var isNewYearTime: Bool {
        return isDateInRange(minDate: 17, minMonth: 12, maxDate: 31, maxMonth: 12)
            || isDateInRange(minDate: 1, minMonth: 1, maxDate: 7, maxMonth: 1)
    }

    var isSpringDay: Bool {
        isDateInRange(
            minDate: 1, minMonth: 3,
            maxDate: 7, maxMonth: 3
        )
    }

    var isCosmicDay: Bool {
        isDateInRange(
            minDate: 12, minMonth: 4,
            maxDate: 12, maxMonth: 4
        )
    }

    var isSummerDay: Bool {
        isDateInRange(
            minDate: 1, minMonth: 6,
            maxDate: 1, maxMonth: 6
        )
    }

    var isAugustDay: Bool {
        isDateInRange(
            minDate: 1, minMonth: 8,
            maxDate: 1, maxMonth: 8
        )
    }

    var isAutumnDay: Bool {
        isDateInRange(
            minDate: 1, minMonth: 9,
            maxDate: 1, maxMonth: 9
        )
    }

    var isHalloweenTime: Bool {
        isDateInRange(
            minDate: 25, minMonth: 10,
            maxDate: 31, maxMonth: 10
        )
    }

    var isWinterDay: Bool {
        isDateInRange(
            minDate: 1, minMonth: 12,
            maxDate: 1, maxMonth: 12
        )
    }

    private func isDateInRange(minDate: Int, minMonth: Int, maxDate: Int, maxMonth: Int) -> Bool {
        let currentDate = Date()
        let currentDateYear = currentDate.year
        let minDate = Date(year: currentDateYear, month: minMonth, day: minDate).startOfDay
        let maxDate = Date(year: currentDateYear, month: maxMonth, day: maxDate).endOfDay
        return currentDate >= minDate && currentDate <= maxDate
    }
}
