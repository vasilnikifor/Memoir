import Foundation

protocol CalendarFactoryDelegate: AnyObject {
    func dateSelected(_ date: Date, day: Day?)
    func dateRated(_ date: Date, rate: DayRate?)
    func rateDay(_ date: Date, rate: DayRate?)
    func addNote(to date: Date)
}

protocol CalendarFactoryProtocol: AnyObject {
    func makeWeekdays() -> [CalendarWeekdayViewModel]
    func makeCalendar(month: Date, delegate: CalendarFactoryDelegate) -> [CalendarDayViewModel]
    func makeYesterdayConsole(delegate: CalendarFactoryDelegate) -> YesterdayConsoleView.Configuration?
    func makeTodayConsole(delegate: CalendarFactoryDelegate) -> TodayConsoleView.Configuration
}

final class CalendarFactory: CalendarFactoryProtocol {
    private let dayService: DayServiceProtocol
    private let cms: CmsProtocol

    init(
        dayService: DayServiceProtocol,
        cms: CmsProtocol
    ) {
        self.dayService = dayService
        self.cms = cms
    }

    func makeWeekdays() -> [CalendarWeekdayViewModel] {
        return Date.shortWeekdaySymbols.map {
            CalendarWeekdayViewModel(text: $0)
        }
    }

    func makeCalendar(month: Date, delegate: CalendarFactoryDelegate) -> [CalendarDayViewModel] {
        var calendarDays: [CalendarDayViewModel] = []
        var processingDate = month.firstMonthCalendarDate.startOfDay
        let firstMonthDate = month.firstDayOfMonth.startOfDay
        let lastMonthDate = month.lastDayOfMonth.startOfDay
        let lastCalendarDate = month.lastMonthCalendarDate.startOfDay
        let todayDate = Date().startOfDay
        let days = dayService.getDays(month: month)

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
                        action: { [processingDate, weak day, weak delegate] in
                            delegate?.dateSelected(processingDate, day: day)
                        }
                    )
                )
            }
            processingDate = processingDate.addDays(1)
        }

        return calendarDays
    }

    func makeYesterdayConsole(delegate: CalendarFactoryDelegate) -> YesterdayConsoleView.Configuration? {
        let yesterdayDate = Date().addDays(-1).startOfDay
        let yesterdayDay = dayService.getDay(date: yesterdayDate)

        guard yesterdayDay?.rate == nil else { return nil }

        return YesterdayConsoleView.Configuration(
            title: cms.home.howWasYesterday,
            isBackgroundBlurred: Date().isHolliday,
            rateBadButtonConfiguration: .init(
                title: cms.rate.bad,
                image: Theme.badRateFilledImage,
                tintColor: Theme.badRateColor,
                action: { [weak delegate] in delegate?.dateRated(yesterdayDate, rate: .bad) }
            ),
            rateNormButtonConfiguration: .init(
                title: cms.rate.good,
                image: Theme.averageRateFilledImage,
                tintColor: Theme.averageRateColor,
                action: { [weak delegate] in delegate?.dateRated(yesterdayDate, rate: .average) }
            ),
            rateGoodButtonConfiguration: .init(
                title: cms.rate.great,
                image: Theme.goodRateFilledImage,
                tintColor: Theme.goodRateColor,
                action: { [weak delegate] in delegate?.dateRated(yesterdayDate, rate: .good) }
            )
        )
    }

    func makeTodayConsole(delegate: CalendarFactoryDelegate) -> TodayConsoleView.Configuration {
        let todayDate = Date().startOfDay
        let todayDay = dayService.getDay(date: todayDate)
        var rateBadButtonConfiguration: ConsoleButton.Configuration?
        var rateNormButtonConfiguration: ConsoleButton.Configuration?
        var rateGoodButtonConfiguration: ConsoleButton.Configuration?

        switch todayDay?.rate {
        case .bad:
            rateBadButtonConfiguration = .init(
                title: cms.rate.rate,
                image: Theme.badRateImage,
                tintColor: Theme.primaryText,
                action: { [weak delegate] in delegate?.rateDay(todayDate, rate: .bad) }
            )
        case .average:
            rateNormButtonConfiguration = .init(
                title: cms.rate.rate,
                image: Theme.averageRateImage,
                tintColor: Theme.primaryText,
                action: { [weak delegate] in delegate?.rateDay(todayDate, rate: .average) }
            )
        case .good:
            rateGoodButtonConfiguration = .init(
                title: cms.rate.rate,
                image: Theme.goodRateImage,
                tintColor: Theme.primaryText,
                action: { [weak delegate] in delegate?.rateDay(todayDate, rate: .good) }
            )
        case .none:
            rateBadButtonConfiguration = .init(
                title: cms.rate.bad,
                image: Theme.badRateFilledImage,
                tintColor: Theme.badRateColor,
                action: { [weak delegate] in delegate?.dateRated(todayDate, rate: .bad) }
            )
            rateNormButtonConfiguration = .init(
                title: cms.rate.good,
                image: Theme.averageRateFilledImage,
                tintColor: Theme.averageRateColor,
                action: { [weak delegate] in delegate?.dateRated(todayDate, rate: .average) }
            )
            rateGoodButtonConfiguration = .init(
                title: cms.rate.great,
                image: Theme.goodRateFilledImage,
                tintColor: Theme.goodRateColor,
                action: { [weak delegate] in delegate?.dateRated(todayDate, rate: .good) }
            )
        }

        let addNoteActionModel = ConsoleButton.Configuration(
            title: cms.common.note,
            image: Theme.addNoteImage,
            tintColor: Theme.primaryText,
            action: { [weak delegate] in delegate?.addNote(to: todayDate) }
        )

        return .init(
            title: cms.calendar.today,
            isBackgroundBlurred: Date().isHolliday,
            rateBadButtonConfiguration: rateBadButtonConfiguration,
            rateNormButtonConfiguration: rateNormButtonConfiguration,
            rateGoodButtonConfiguration: rateGoodButtonConfiguration,
            addNoteButtonConfiguration: addNoteActionModel
        )
    }
}
