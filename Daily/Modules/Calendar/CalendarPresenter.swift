import UIKit

protocol CalendarPresenterProtocol: AnyObject {
    func viewLoaded()
    func rateDayTapped()
    func addNoteTapped()
}

protocol CalendarDelegate: AnyObject {
    func update()
}

final class CalendarPresenter {
    private weak var view: CalendarViewControllerProtocol?
    private let factory: CalendarFactoryProtocol
    private let dayService: DayServiceProtocol
    private let analyticsService: AnalyticsServiceProtocol
    private var todayDay: Day?
    
    var todayRateImage: UIImage {
        switch todayDay?.rate {
        case .none:
            return Theme.rateDayImage
        case .bad:
            return Theme.badRateImage
        case .average:
            return Theme.averageRateImage
        case .good:
            return Theme.goodRateImage
        }
    }
    
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
}

extension CalendarPresenter: CalendarPresenterProtocol {
    func viewLoaded() {
        todayDay = dayService.getDay(date: Date().startOfDay)
        view?.setupInitialState(calendarViewModel: CalendarViewModel(month: Date(), delegate: self))
        view?.updateRateImage(image: todayRateImage)
        analyticsService.sendEvent("calendar_page_loaded")
    }
    
    func rateDayTapped() {
        analyticsService.sendEvent("calendar_page_rate_day_tapped")
        
        view?.present(
            DayRateAssembler.assemble(
                DayRateInputModel(
                    date: todayDay?.date ?? Date(),
                    selectedRate: todayDay?.rate,
                    delegate: self
                )
            )
        )
    }
    
    func addNoteTapped() {
        analyticsService.sendEvent("calendar_page_add_note_tapped")
        
        view?.present(
            DayNoteAssembler.assemble(
                DayNoteInputModel(
                    date: todayDay?.date ?? Date(),
                    note: nil,
                    delegate: self
                )
            )
        )
    }
}

extension CalendarPresenter: CalendarViewDelegate {
    func getMonthsWeekDays() -> [CalendarWeekdayViewModel] {
        return factory.make()
    }
    
    func getMonthsDays(month: Date) -> [CalendarDayViewModel] {
        return factory.make(month: month, delegate: self)
    }
    
    func monthSelected(month: Date) {
        if month.startOfDay == Date().startOfDay {
            analyticsService.sendEvent("calendar_page_current_month_selected")
        } else {
            analyticsService.sendEvent("calendar_page_month_selected")
        }
        
        view?.push(
            MonthRecordsAssembler.assemble(
                MonthRecordsInputModel(
                    month: month,
                    delegate: self
                )
            )
        )
    }
}

extension CalendarPresenter: CalendarFactoryDelegate {
    func dateSelected(_ date: Date, day: Day?) {
        if date.startOfDay == Date().startOfDay {
            analyticsService.sendEvent("calendar_page_today_selected")
        } else {
            analyticsService.sendEvent("calendar_page_day_selected")
        }
            
        view?.push(
            DayRecordsAssembler.assemble(
                DayRecordsInputModel(
                    date: date,
                    day: day,
                    delegate: self
                )
            )
        )
    }
}

extension CalendarPresenter: CalendarDelegate {
    func update() {
        todayDay = dayService.getDay(date: Date().startOfDay)
        view?.update()
        view?.updateRateImage(image: todayRateImage)
    }
}
