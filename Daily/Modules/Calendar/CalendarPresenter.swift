import Foundation

protocol CalendarPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class CalendarPresenter {
    private weak var view: CalendarViewControllerProtocol?
    private let factory: CalendarFactoryProtocol
    
    init(view: CalendarViewControllerProtocol,
         factory: CalendarFactoryProtocol) {
        self.view = view
        self.factory = factory
    }
}

extension CalendarPresenter: CalendarPresenterProtocol {
    func viewDidLoad() {
        view?.setupInitialState(calendarViewModel: CalendarViewModel(month: Date(), delegate: self))
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
    func dateSelected(_ date: Date) {
        print(date)
    }
}
