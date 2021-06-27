import Foundation

final class DayRateAssembler {
    static func assemble(_ inputModel: DayRateInputModel) -> DayRateViewController {
        let viewContorller = DayRateViewController()
        let presenter = DayRatePresenter(view: viewContorller, inputModel: inputModel)
        viewContorller.presenter = presenter
        return viewContorller
    }
}
