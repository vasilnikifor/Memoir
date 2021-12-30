import UIKit

protocol MonthRecordsPresenterProtocol {
    func viewLoaded()
}

final class MonthRecordsPresenter {
    weak var view: MonthRecordsViewControllerProtocol?
    let dayService: DayServiceProtocol
    let month: Date
    weak var delegate: CalendarDelegate?
    
    init(view: MonthRecordsViewControllerProtocol,
        inputModel: MonthRecordsInputModel,
        dayService: DayServiceProtocol) {
        self.view = view
        self.dayService = dayService
        month = inputModel.month
        delegate = inputModel.delegate
    }
    
    func openNote(day: Day, noteRecord: NoteRecord?) {
        guard let date = day.date else { return }
        
        view?.present(
            DayNoteAssembler.assemble(
                DayNoteInputModel(
                    date: date,
                    note: noteRecord,
                    delegate: self
                )
            )
        )
    }
    
    func openDayRate(day: Day) {
        guard let date = day.date else { return }
        
        view?.present(
            DayRateAssembler.assemble(
                DayRateInputModel(
                    date: date,
                    selectedRate: day.rate,
                    delegate: self
                )
            )
        )
    }
    
    func updateDataSource() {
        var dataSource: [MonthRecordsDataSource] = []
            
        dayService.getDays(of: month).forEach { day in
            guard !day.isEmpty else { return }
            
            var sectionDataSource: [MonthRecordsSectionDataSource] = []
            
            day.records?
                .sorted { record1, record2 in
                    guard let record1 = record1 as? Record,
                          let record1Time = record1.time,
                          let record2 = record2 as? Record,
                          let record2Time = record2.time else { return false }
                    return record1Time < record2Time
                }
                .forEach { record in
                    if let noteRecord = record as? NoteRecord {
                        sectionDataSource.append(
                            .note(
                                viewModel: DayNoteRecordViewModel(
                                    text: noteRecord.text ?? "",
                                    time: (noteRecord.time ?? Date()).timeRepresentation,
                                    action: { [weak self] in self?.openNote(day: day, noteRecord: noteRecord)}
                                )
                            )
                        )
                    }
                }
            
            sectionDataSource.append(
                .actions(
                    viewModel: DayActionsViewModel(
                        rate: day.rate,
                        rateAction: { [weak self] in self?.openDayRate(day: day)},
                        addNoteAction: { [weak self] in self?.openNote(day: day, noteRecord: nil)}
                    )
                )
            )
            
            dataSource.append(
                MonthRecordsDataSource(
                    sectionHeaderViewModel: DayHeaderViewModel(
                        title: day.date?.dateShortRepresentation ?? "",
                        rate: day.rate,
                        action: { [weak self] in self?.openDayRate(day: day)}
                    ),
                    sectionDataSource: sectionDataSource
                )
            )
        }
        
        view?.update(dataSource: dataSource)
    }
}

extension MonthRecordsPresenter: MonthRecordsPresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(title: month.monthRepresentation)
        updateDataSource()
    }
}

extension MonthRecordsPresenter: CalendarDelegate {
    func update() {
        updateDataSource()
        delegate?.update()
    }
}
