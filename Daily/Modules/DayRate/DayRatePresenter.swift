import Foundation

protocol DayRatePresenterProtocol: AnyObject {
    func viewLoaded()
    func closeTapped()
    func removeTapped()
    func badRateTapped()
    func averageRateTapped()
    func goodRateTapped()
}

final class DayRatePresenter {
    private weak var view: DayRateViewControllerProtocol?
    private weak var calendarDelegate: CalendarDelegate?
    private var date: Date
    
    init(view: DayRateViewControllerProtocol,
         calendarDelegate: CalendarDelegate?,
         date: Date) {
        self.view = view
        self.calendarDelegate = calendarDelegate
        self.date = date
    }
}

extension DayRatePresenter: DayRatePresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState()
    }
    
    func closeTapped() {
        view?.dismiss()
    }
    
    func removeTapped() {
        // TODO: - rate logic
        calendarDelegate?.update()
        view?.dismiss()
    }
    
    func badRateTapped() {
        // TODO: - rate logic
        calendarDelegate?.update()
        view?.dismiss()
    }
    
    func averageRateTapped() {
        // TODO: - rate logic
        calendarDelegate?.update()
        view?.dismiss()
    }
    
    func goodRateTapped() {
        // TODO: - rate logic
        calendarDelegate?.update()
        view?.dismiss()
    }
}
