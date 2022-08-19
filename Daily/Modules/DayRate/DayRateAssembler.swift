import Foundation

final class DayRateAssembler {
    static func assemble(_ inputModel: DayRateInputModel) -> DayRateViewController {
        let viewController = DayRateViewController()
        let dayService = DayService()
        let analyticsService = AnalyticsService()
        let presenter = DayRatePresenter(
            view: viewController,
            dayService: dayService,
            analyticsService: analyticsService,
            inputModel: inputModel
        )
        viewController.presenter = presenter
        return viewController
    }
}
