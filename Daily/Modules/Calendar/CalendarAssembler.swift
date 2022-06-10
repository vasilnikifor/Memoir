import Foundation

final class CalendarAssembler {
    static func assemble() -> CalendarViewController {
        let viewController = CalendarViewController()
        let dayService = DayService()
        let factory = CalendarFactory(dayService: dayService)
        let analyticsService = AnalyticsService()
        let presenter = CalendarPresenter(
            view: viewController,
            factory: factory,
            dayService: dayService,
            analyticsService: analyticsService
        )
        viewController.presenter = presenter
        return viewController
    }
}
