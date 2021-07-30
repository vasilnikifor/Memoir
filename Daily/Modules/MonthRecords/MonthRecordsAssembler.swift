import Foundation

final class MonthRecordsAssembler {
    static func assemble(_ inputModel: MonthRecordsInputModel) -> MonthRecordsViewController {
        let viewController = MonthRecordsViewController()
        let presenter = MonthRecordsPresenter(view: viewController, inputModel: inputModel)
        viewController.presenter = presenter
        return viewController
    }
}
