import UIKit

protocol DayRecordsCoordinatorProtocol: AnyObject {
    func showDayNote(date: Date, note: NoteRecord?, delegate: CalendarDelegate?)
    func showDayRate(date: Date, rate: DayRate?, delegate: CalendarDelegate?)
}

protocol DayRecordsPresenterProtocol {
    func viewLoaded()
    func rateDayTapped()
    func addNoteTapped()
}

final class DayRecordsPresenter {
    private weak var view: DayRecordsViewControllerProtocol?
    private weak var coordinator: DayRecordsCoordinatorProtocol?
    private weak var delegate: CalendarDelegate?
    private let cms: CmsProtocol
    private let dayService: DayServiceProtocol
    private let date: Date
    private var day: Day?
    private let emptyStateIllustration = UIImage(named: "illustration\(Int.random(in: 1 ... 9))")

    init(
        view: DayRecordsViewControllerProtocol,
        coordinator: DayRecordsCoordinatorProtocol,
        cms: CmsProtocol,
        dayService: DayServiceProtocol,
        inputModel: DayRecordsInputModel
    ) {
        self.view = view
        self.coordinator = coordinator
        self.cms = cms
        self.dayService = dayService
        delegate = inputModel.delegate
        date = inputModel.date
        day = inputModel.day
    }

    private func openNote(_ noteRecord: NoteRecord?) {
        coordinator?.showDayNote(date: date, note: noteRecord, delegate: self)
    }

    private func updateDataSource() {
        day = dayService.getDay(date: date)

        let dataSource: [DayRecordsDataSource]
        let emptyStateModel: EmptyStateView.Model?
        if let records = day?.records, records.count > 0 {
            emptyStateModel = nil
            dataSource = records
                .sorted { record1, record2 in
                    guard let record1 = record1 as? Record,
                          let record1Time = record1.time,
                          let record2 = record2 as? Record,
                          let record2Time = record2.time else { return false }
                    return record1Time < record2Time
                }
                .compactMap { record in
                    if let noteRecord = record as? NoteRecord {
                        return .note(
                            viewModel: NoteRecordViewModel(
                                text: noteRecord.text.orEmpty,
                                time: (noteRecord.time ?? Date()).timeRepresentation,
                                action: { [weak self, weak noteRecord] in self?.openNote(noteRecord) }
                            )
                        )
                    } else {
                        return nil
                    }
                }
        } else {
            dataSource = []
            emptyStateModel = .init(
                illustrationImage: emptyStateIllustration,
                title: cms.note.emptyStateTitle,
                subtitle: cms.note.emptyStateSubtitle,
                buttonIcon: .addNote,
                buttonTitle: cms.note.addNote,
                buttonAction: { [weak self] in
                    self?.openNote(nil)
                }
            )
        }

        view?.update(
            rate: day?.rate,
            dataSource: dataSource,
            emptyStateModel: emptyStateModel
        )
    }
}

extension DayRecordsPresenter: DayRecordsPresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(title: date.dateRepresentation)
        updateDataSource()
    }

    func rateDayTapped() {
        coordinator?.showDayRate(date: date, rate: day?.rate, delegate: self)
    }

    func addNoteTapped() {
        openNote(nil)
    }
}

extension DayRecordsPresenter: CalendarDelegate {
    func update() {
        updateDataSource()
        delegate?.update()
    }
}
