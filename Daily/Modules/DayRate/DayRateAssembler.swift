import Foundation

final class DayRateAssembler {
    static func assemble(_ inputModel: DayRateInputModel) -> DayRateViewController {
        let viewContorller = DayRateViewController()
        let dayService = DayService()
        let analyticsService = AnalyticsService()
        let presenter = DayRatePresenter(
            view: viewContorller,
            dayService: dayService,
            analyticsService: analyticsService,
            inputModel: inputModel
        )
        viewContorller.presenter = presenter
        return viewContorller
    }
}
