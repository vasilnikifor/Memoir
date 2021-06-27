import Foundation

protocol DayRecordsPresenterProtocol {
    func viewLoaded()
}

final class DayRecordsPresenter {
    private weak var view: DayRecordsViewControllerProtocol?
    private weak var delegate: CalendarDelegate?
    private let date: Date
    private let day: Day?
    
    init(view: DayRecordsViewControllerProtocol,
         inputModel: DayRecordsInputModel) {
        self.view = view
        delegate = inputModel.delegate
        date = inputModel.date
        day = inputModel.day
    }
}

extension DayRecordsPresenter: DayRecordsPresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(dateText: date.dateRepresentation)
    }
}
