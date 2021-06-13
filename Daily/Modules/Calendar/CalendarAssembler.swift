import Foundation

final class CalendarAssembler {
    static func assemble() -> CalendarViewController {
        let viewController = CalendarViewController()
        let recordsService = RecordsService()
        let factory = CalendarFactory(recordsService: recordsService)
        let presenter = CalendarPresenter(view: viewController, factory: factory)
        viewController.presenter = presenter
        return viewController
    }
}
