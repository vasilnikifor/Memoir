import Foundation

final class CalendarAssembler {
    static func assemble() -> CalendarViewController {
        let viewController = CalendarViewController()
        let dayService = DayService()
        let cms = Cms()
        let factory = CalendarFactory(dayService: dayService, cms: cms)
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
