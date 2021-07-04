import Foundation

final class DayRecordsAssembler {
    static func assemble(_ inputModel: DayRecordsInputModel) -> DayRecordsViewController {
        let viewController = DayRecordsViewController()
        let dayService = DayService()
        let presenter = DayRecordsPresenter(view: viewController, dayService: dayService, inputModel: inputModel)
        viewController.presenter = presenter
        return viewController
    }
}
