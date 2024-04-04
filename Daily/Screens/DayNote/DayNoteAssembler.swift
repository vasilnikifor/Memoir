import Foundation

final class DayNoteAssembler {
    static func assemble(
        inputModule: DayNoteInputModel,
        coordinator: DayNoteCoordinatorProtocol
    ) -> DayNoteViewController {
        let viewController = DayNoteViewController()
        let dayService = DayService()
        let cms = Cms()
        let presenter = DayNotePresenter(
            view: viewController,
            coordinator: coordinator,
            dayService: dayService,
            cms: cms,
            inputModel: inputModule
        )
        viewController.presenter = presenter
        return viewController
    }
}
