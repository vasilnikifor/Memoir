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
    
    init(view: CalendarViewControllerProtocol,
         factory: CalendarFactoryProtocol,
         dayService: DayServiceProtocol) {
        self.view = view
        self.factory = factory
        self.dayService = dayService
    }
}

extension CalendarPresenter: CalendarPresenterProtocol {
    func viewLoaded() {
        todayDay = dayService.getDay(date: Date().startOfDay)
        view?.setupInitialState(calendarViewModel: CalendarViewModel(month: Date(), delegate: self))
        view?.updateRateImage(image: todayRateImage)
    }
    
    func rateDayTapped() {
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
}

extension CalendarPresenter: CalendarFactoryDelegate {
    func dateSelected(_ date: Date, day: Day?) {
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
