import Foundation

final class CalendarAssembler {
    static func assemble() -> CalendarViewController {
        let viewController = CalendarViewController()
        let factory = CalendarFactory()
        let presenter = CalendarPresenter(view: viewController, factory: factory)
        viewController.presenter = presenter
        return viewController
    }
}
