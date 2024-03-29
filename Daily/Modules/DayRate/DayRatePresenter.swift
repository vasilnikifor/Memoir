import Foundation

protocol DayRateCoordinatorProtocol: AnyObject {
    func dismiss()
}

protocol DayRatePresenterProtocol: AnyObject {
    func viewLoaded()
    func closeTapped()
    func removeTapped()
}

final class DayRatePresenter {
    private weak var view: DayRateViewControllerProtocol?
    private weak var coordinator: DayRateCoordinatorProtocol?
    private weak var calendarDelegate: CalendarDelegate?
    private var dayService: DayServiceProtocol
    private var date: Date
    private var selectedRate: DayRate?

    init(
        view: DayRateViewControllerProtocol,
        coordinator: DayRateCoordinatorProtocol,
        dayService: DayServiceProtocol,
        inputModel: DayRateInputModel
    ) {
        self.view = view
        self.coordinator = coordinator
        self.dayService = dayService
        calendarDelegate = inputModel.delegate
        date = inputModel.date
        selectedRate = inputModel.selectedRate
    }

    private func update(selectedRate: DayRate?) {
        dayService.rateDay(of: date, rate: selectedRate)
        calendarDelegate?.update()
        coordinator?.dismiss()
    }
}

extension DayRatePresenter: DayRatePresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(dateText: date.dateRepresentation)

        view?.update(
            badRateViewModel: DayRateViewModel(
                image: .badRateFilled,
                tintColor: .dBadRateColor,
                isSelected: selectedRate == .bad,
                action: { [weak self] in self?.update(selectedRate: .bad) }
            ),
            averageRateViewModel: DayRateViewModel(
                image: .averageRateFilled,
                tintColor: .dAverageRateColor,
                isSelected: selectedRate == .average,
                action: { [weak self] in self?.update(selectedRate: .average) }
            ),
            goodRateViewModel: DayRateViewModel(
                image: .goodRateFilled,
                tintColor: .dGoodRateColor,
                isSelected: selectedRate == .good,
                action: { [weak self] in self?.update(selectedRate: .good) }
            )
        )
    }

    func closeTapped() {
        coordinator?.dismiss()
    }

    func removeTapped() {
        update(selectedRate: nil)
    }
}
