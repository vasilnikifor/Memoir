import Foundation

protocol DayRatePresenterProtocol: AnyObject {
    func viewLoaded()
    func closeTapped()
    func removeTapped()
}

final class DayRatePresenter {
    private weak var view: DayRateViewControllerProtocol?
    private weak var calendarDelegate: CalendarDelegate?
    private var date: Date
    private var day: Day?
    
    init(view: DayRateViewControllerProtocol,
         inputModel: DayRateInputModel) {
        self.view = view
        calendarDelegate = inputModel.delegate
        date = inputModel.date
        day = inputModel.day
    }
    
    private func update(selectedRate: DayRate?) {
        day?.rate = selectedRate
        calendarDelegate?.update()
        view?.dismiss()
    }
}

extension DayRatePresenter: DayRatePresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(dateText: date.dateRepresentation)
        
        view?.update(
            badRateViewModel: DayRateViewModel(
                image: Theme.badRateImage,
                tintColor: Theme.badRateColor,
                isSelected: day?.rate == .bad,
                action: { [weak self] in self?.update(selectedRate: .bad) }
            ),
            averageRateViewModel: DayRateViewModel(
                image: Theme.averageRateImage,
                tintColor: Theme.averageRateColor,
                isSelected: day?.rate == .average,
                action: { [weak self] in self?.update(selectedRate: .average) }
            ),
            goodRateViewModel: DayRateViewModel(
                image: Theme.goodRateImage,
                tintColor: Theme.goodRateColor,
                isSelected: day?.rate == .good,
                action: { [weak self] in self?.update(selectedRate: .good) }
            )
        )
    }
    
    func closeTapped() {
        view?.dismiss()
    }
    
    func removeTapped() {
        update(selectedRate: nil)
    }
}
