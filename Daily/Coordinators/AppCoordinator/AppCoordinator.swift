import UIKit

final class AppCoordinator {
    private let transitionHandler: TransitionHandler

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func start() {
        let viewController = CalendarAssembler.assemble(coordinator: self)
        transitionHandler.setRoot(viewController, animated: false)
    }
}

extension AppCoordinator: CalendarCoordinatorProtocol, DayRecordsCoordinatorProtocol, MonthRecordsCoordinatorProtocol {
    func showMonthRecords(month: Date, delegate: CalendarDelegate?) {
        let inputModel = MonthRecordsInputModel(month: month, delegate: delegate)
        let viewController = MonthRecordsAssembler.assemble(inputModel: inputModel, coordinator: self)
        transitionHandler.push(viewController)
    }

    func showDayRecords(date: Date, day: Day?, delegate: CalendarDelegate?) {
        let inputModel = DayRecordsInputModel(date: date, day: day, delegate: delegate)
        let viewController = DayRecordsAssembler.assemble(inputModel: inputModel, coordinator: self)
        transitionHandler.push(viewController)
    }

    func showDayNote(date: Date, note: NoteRecord?, delegate: CalendarDelegate?) {
        let inputModel = DayNoteInputModel(date: date, note: note, delegate: delegate)
        let viewController = DayNoteAssembler.assemble(inputModule: inputModel, coordinator: self)
        transitionHandler.present(viewController)
    }

    func showDayRate(date: Date, rate: DayRate?, delegate: CalendarDelegate?) {
        let inputModel = DayRateInputModel(date: date, selectedRate: rate, delegate: delegate)
        let viewController = DayRateAssembler.assemble(inputModel: inputModel, coordinator: self)
        transitionHandler.present(viewController)
    }
}

extension AppCoordinator: DayNoteCoordinatorProtocol, DayRateCoordinatorProtocol {
    func dismiss() {
        transitionHandler.dismiss()
    }
}
