import UIKit

protocol DayRecordsPresenterProtocol {
    func viewLoaded()
    func rateDayTapped()
    func addNoteTapped()
}

final class DayRecordsPresenter {
    private weak var view: DayRecordsViewControllerProtocol?
    private var dayService: DayServiceProtocol
    private weak var delegate: CalendarDelegate?
    private let date: Date
    private var day: Day?
    
    var rateImage: UIImage {
        switch day?.rate {
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
    
    init(view: DayRecordsViewControllerProtocol,
         dayService: DayServiceProtocol,
         inputModel: DayRecordsInputModel) {
        self.view = view
        self.dayService = dayService
        delegate = inputModel.delegate
        date = inputModel.date
        day = inputModel.day
    }
}

extension DayRecordsPresenter: DayRecordsPresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(dateText: date.dateRepresentation)
        update()
    }
    
    func rateDayTapped() {
        view?.present(
            DayRateAssembler.assemble(
                DayRateInputModel(
                    date: date,
                    selectedRate: day?.rate,
                    delegate: self
                )
            )
        )
    }
    
    func addNoteTapped() {
        
    }
}


extension DayRecordsPresenter: CalendarDelegate {
    func update() {
        day = dayService.getDay(date: date)
        view?.update(rateImage: rateImage)
        delegate?.update()
    }
}
