import Foundation

final class DayRecordsAssembler {
    static func assemble(
        inputModel: DayRecordsInputModel,
        coordinator: DayRecordsCoordinatorProtocol
    ) -> DayRecordsViewController {
        let viewController = DayRecordsViewController()
        let cms = Cms()
        let dayService = DayService()
        let presenter = DayRecordsPresenter(
            view: viewController,
            coordinator: coordinator,
            cms: cms,
            dayService: dayService,
            inputModel: inputModel
        )
        viewController.presenter = presenter
        return viewController
    }
}
