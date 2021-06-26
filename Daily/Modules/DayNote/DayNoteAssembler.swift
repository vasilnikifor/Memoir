import Foundation

final class DayNoteAssembler {
    static func assemble() -> DayNoteViewController {
        let viewController = DayNoteViewController()
        let presenter = DayNotePresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
