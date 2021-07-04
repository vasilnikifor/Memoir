import Foundation

final class CalendarAssembler {
    static func assemble() -> CalendarViewController {
        let viewController = CalendarViewController()
        let factory = CalendarFactory(dayService: DayService())
        let presenter = CalendarPresenter(view: viewController, factory: factory, dayService: DayService())
        viewController.presenter = presenter
        return viewController
    }
}
