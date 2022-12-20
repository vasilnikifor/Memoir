import Foundation

final class MonthRecordsAssembler {
    static func assemble(
        inputModel: MonthRecordsInputModel,
        coordinator: MonthRecordsCoordinatorProtocol
    ) -> MonthRecordsViewController {
        let viewController = MonthRecordsViewController()
        let dayService = DayService()
        let analyticsService = AnalyticsService()
        let cms = Cms()
        let factory = MonthRecordsFactory(dayService: dayService)
        let presenter = MonthRecordsPresenter(
            view: viewController,
            coordinator: coordinator,
            dayService: dayService,
            analyticsService: analyticsService,
            cms: cms,
            factory: factory,
            inputModel: inputModel
        )
        viewController.presenter = presenter
        return viewController
    }
}
