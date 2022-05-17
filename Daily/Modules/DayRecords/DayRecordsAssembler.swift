import Foundation

final class DayRecordsAssembler {
    static func assemble(_ inputModel: DayRecordsInputModel) -> DayRecordsViewController {
        let viewController = DayRecordsViewController()
        let dayService = DayService()
        let analyticsService = AnalyticsService()
        let presenter = DayRecordsPresenter(
            view: viewController,
            dayService: dayService,
            analyticsService: analyticsService,
            inputModel: inputModel
        )
        viewController.presenter = presenter
        return viewController
    }
}
