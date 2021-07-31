import Foundation

final class MonthRecordsAssembler {
    static func assemble(_ inputModel: MonthRecordsInputModel) -> MonthRecordsViewController {
        let viewController = MonthRecordsViewController()
        let dayService = DayService()
        let presenter = MonthRecordsPresenter(view: viewController, inputModel: inputModel, dayService: dayService)
        viewController.presenter = presenter
        return viewController
    }
}
