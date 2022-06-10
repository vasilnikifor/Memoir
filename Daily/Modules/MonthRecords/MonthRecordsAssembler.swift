import Foundation

final class MonthRecordsAssembler {
    static func assemble(_ inputModel: MonthRecordsInputModel) -> MonthRecordsViewController {
        let viewController = MonthRecordsViewController()
        let dayService = DayService()
        let analyticsService = AnalyticsService()
        let presenter = MonthRecordsPresenter(
            view: viewController,
            dayService: dayService,
            analyticsService: analyticsService,
            inputModel: inputModel
        )
        viewController.presenter = presenter
        return viewController
    }
}
