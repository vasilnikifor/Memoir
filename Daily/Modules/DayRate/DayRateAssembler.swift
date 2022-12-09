import Foundation

final class DayRateAssembler {
    static func assemble(
        inputModel: DayRateInputModel,
        coordinator: DayRateCoordinatorProtocol
    ) -> DayRateViewController {
        let viewController = DayRateViewController()
        let dayService = DayService()
        let analyticsService = AnalyticsService()
        let presenter = DayRatePresenter(
            view: viewController,
            coordinator: coordinator,
            dayService: dayService,
            analyticsService: analyticsService,
            inputModel: inputModel
        )
        viewController.presenter = presenter
        return viewController
    }
}
