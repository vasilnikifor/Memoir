import Foundation

final class DayRecordsAssembler {
    static func assemble(
        inputModel: DayRecordsInputModel,
        coordinator: DayRecordsCoordinatorProtocol
    ) -> DayRecordsViewController {
        let viewController = DayRecordsViewController()
        let cms = Cms()
        let dayService = DayService()
        let analyticsService = AnalyticsService()
        let presenter = DayRecordsPresenter(
            view: viewController,
            coordinator: coordinator,
            cms: cms,
            dayService: dayService,
            analyticsService: analyticsService,
            inputModel: inputModel
        )
        viewController.presenter = presenter
        return viewController
    }
}
