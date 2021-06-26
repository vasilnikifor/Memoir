import Foundation

protocol CalendarPresenterProtocol: AnyObject {
    func viewLoaded()
    func rateDayTapped()
    func addNoteTapped()
    func addImageTapped()
    func takePhotoTapped()
}

protocol CalendarDelegate: AnyObject {
    func update()
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
    func viewLoaded() {
        view?.setupInitialState(calendarViewModel: CalendarViewModel(month: Date(), delegate: self))
    }
    
    func rateDayTapped() {
        view?.present(DayRateAssembler.assemble(date: Date(), calendarDelegate: self))
    }
    
    func addNoteTapped() {
        view?.present(DayNoteAssembler.assemble())
    }
    
    func addImageTapped() {}
    
    func takePhotoTapped() {}
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
        print("date \(date)")
    }
}

extension CalendarPresenter: CalendarDelegate {
    func update() {
        print("update")
    }
}
