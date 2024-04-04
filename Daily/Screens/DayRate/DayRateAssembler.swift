import Foundation

final class DayRateAssembler {
    static func assemble(
        inputModel: DayRateInputModel,
        coordinator: DayRateCoordinatorProtocol
    ) -> DayRateViewController {
        let viewController = DayRateViewController()
        let dayService = DayService()
        let presenter = DayRatePresenter(
            view: viewController,
            coordinator: coordinator,
            dayService: dayService,
            inputModel: inputModel
        )
        viewController.presenter = presenter
        return viewController
    }
}
