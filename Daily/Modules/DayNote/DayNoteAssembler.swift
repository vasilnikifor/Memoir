import Foundation

final class DayNoteAssembler {
    static func assemble(_ inputModule: DayNoteInputModel) -> DayNoteViewController {
        let viewController = DayNoteViewController()
        let dayService = DayService()
        let presenter = DayNotePresenter(view: viewController, dayService: dayService, inputModel: inputModule)
        viewController.presenter = presenter
        return viewController
    }
}
