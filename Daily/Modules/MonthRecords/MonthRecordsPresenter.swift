import Foundation

protocol MonthRecordsPresenterProtocol {
    
}

final class MonthRecordsPresenter {
    private weak var view: MonthRecordsViewControllerProtocol?
    
    init(view: MonthRecordsViewControllerProtocol,
        inputModel: MonthRecordsInputModel) {
        self.view = view
    }
}

extension MonthRecordsPresenter: MonthRecordsPresenterProtocol {
    
}
