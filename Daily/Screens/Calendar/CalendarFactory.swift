import Foundation

protocol CalendarFactoryDelegate: AnyObject {
    func dateSelected(_ date: Date, day: Day?)
    func dateRated(_ date: Date, rate: DayRate?)
    func rateDay(_ date: Date, rate: DayRate?)
    func addNote(to date: Date)
}

protocol CalendarFactoryProtocol: AnyObject {
    func makeWeekdays() -> [CalendarWeekdayViewModel]
    func makeCalendar(month: Date, delegate: CalendarFactoryDelegate) -> [CalendarDayViewConfiguration]
    func makeYesterdayConsole(delegate: CalendarFactoryDelegate) -> RateConsoleView.Configuration?
    func makeTodayConsole(delegate: CalendarFactoryDelegate) -> RateConsoleView.Configuration?
    func makeNoteConsole(delegate: CalendarFactoryDelegate) -> NoteConsoleView.Configuration
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
        let calendar = Date.calendar
        let weekdaySymbols = calendar.weekdaySymbols
        let shortWeekdaySymbols = calendar.shortWeekdaySymbols
        let firstWeekdayIndices = calendar.firstWeekday - 1
        let lastWeekdayIndices = shortWeekdaySymbols.count - 1
        var weekdayIndices: [Int] = []
        (firstWeekdayIndices ... lastWeekdayIndices).forEach { weekdayIndices.append($0) }
        (0 ..< firstWeekdayIndices).forEach { weekdayIndices.append($0) }
        return weekdayIndices.map {
            let weekdaySymbol = weekdaySymbols[$0]
            let shortWeekdaySymbol = shortWeekdaySymbols[$0]
            return CalendarWeekdayViewModel(text: shortWeekdaySymbol, accessibilityLabel: weekdaySymbol)
        }
    }

    func makeCalendar(month: Date, delegate: CalendarFactoryDelegate) -> [CalendarDayViewConfiguration] {
        var calendarDays: [CalendarDayViewConfiguration] = []
        var processingDate = month.firstMonthCalendarDate.startOfDay
        let firstMonthDate = month.firstDayOfMonth.startOfDay
        let lastMonthDate = month.lastDayOfMonth.startOfDay
        let monthDaysCount = 41
        let lastCalendarDate = processingDate.addDays(monthDaysCount).startOfDay
        let todayDate = Date().startOfDay
        let days = dayService.getDays(start: processingDate, end: lastCalendarDate)

        while processingDate <= lastCalendarDate {
            let day = days.first(where: { $0.date?.startOfDay == processingDate })

            let state: CalendarDayViewConfiguration.State = if processingDate < firstMonthDate || processingDate > lastMonthDate {
                .inactive
            } else if let day, !day.isEmpty {
                .filled(dayRate: day.rate)
            } else {
                .empty
            }

            calendarDays.append(
                CalendarDayViewConfiguration(
                    date: processingDate,
                    isToday: processingDate == todayDate,
                    state: state,
                    action: { [processingDate, weak day, weak delegate] in
                        delegate?.dateSelected(processingDate, day: day)
                    }
                )
            )

            processingDate = processingDate.addDays(1)
        }

        return calendarDays
    }

    func makeYesterdayConsole(delegate: CalendarFactoryDelegate) -> RateConsoleView.Configuration? {
        return makeRateConsole(for: Date().addDays(-1).startOfDay, delegate: delegate)
    }

    func makeTodayConsole(delegate: CalendarFactoryDelegate) -> RateConsoleView.Configuration? {
        return makeRateConsole(for: Date().startOfDay, delegate: delegate)
    }

    func makeNoteConsole(delegate: CalendarFactoryDelegate) -> NoteConsoleView.Configuration {
        let currentDate = Date()
        return NoteConsoleView.Configuration(
            title: cms.note.addNote,
            isBackgroundBlurred: currentDate.isWallpaperDay,
            action: { [weak delegate] in delegate?.addNote(to: currentDate) }
        )
    }

    private func makeRateConsole(
        for configurableDate: Date,
        delegate: CalendarFactoryDelegate
    ) -> RateConsoleView.Configuration? {
        let date = configurableDate.startOfDay
        let day = dayService.getDay(date: date)

        guard day?.rate == nil else { return nil }

        let today = Date().startOfDay
        let isYesterday = today.addDays(-1) == date
        let isToday = today == date
        let title: String

        if isToday {
            title = cms.home.howIsToday
        } else if isYesterday {
            title = cms.home.howWasYesterday
        } else {
            title = .empty
        }

        return RateConsoleView.Configuration(
            title: title,
            isBackgroundBlurred: today.isWallpaperDay,
            rateBadButtonConfiguration: .init(
                title: cms.rate.bad,
                image: .badRateFilled,
                tintColor: .dBadRateColor,
                action: { [weak delegate] in delegate?.dateRated(date, rate: .bad) }
            ),
            rateNormButtonConfiguration: .init(
                title: cms.rate.good,
                image: .averageRateFilled,
                tintColor: .dAverageRateColor,
                action: { [weak delegate] in delegate?.dateRated(date, rate: .average) }
            ),
            rateGoodButtonConfiguration: .init(
                title: cms.rate.great,
                image: .goodRateFilled,
                tintColor: .dGoodRateColor,
                action: { [weak delegate] in delegate?.dateRated(date, rate: .good) }
            )
        )
    }
}
