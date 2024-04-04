import Foundation

final class CalendarAssembler {
    static func assemble(coordinator: CalendarCoordinatorProtocol) -> CalendarViewController {
        let viewController = CalendarViewController()
        let dayService = DayService()
        let cms = Cms()
        let factory = CalendarFactory(dayService: dayService, cms: cms)
        let presenter = CalendarPresenter(
            view: viewController,
            coordinator: coordinator,
            dayService: dayService,
            cms: cms,
            factory: factory
        )
        viewController.presenter = presenter
        return viewController
    }
}
