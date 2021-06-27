import Foundation

final class DayRecordsAssembler {
    static func assemble(_ inputModel: DayRecordsInputModel) -> DayRecordsViewController {
        let viewController = DayRecordsViewController()
        let presenter = DayRecordsPresenter(view: viewController, inputModel: inputModel)
        viewController.presenter = presenter
        return viewController
    }
}
