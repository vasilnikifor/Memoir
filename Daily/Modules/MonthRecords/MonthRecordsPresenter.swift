import UIKit

protocol MonthRecordsPresenterProtocol {
    func viewLoaded()
}

final class MonthRecordsPresenter {
    weak var view: MonthRecordsViewControllerProtocol?
    let dayService: DayServiceProtocol
    let analyticsService: AnalyticsServiceProtocol
    let month: Date
    weak var delegate: CalendarDelegate?
    
    init(
        view: MonthRecordsViewControllerProtocol,
        dayService: DayServiceProtocol,
        analyticsService: AnalyticsServiceProtocol,
        inputModel: MonthRecordsInputModel
    ) {
        self.view = view
        self.dayService = dayService
        self.analyticsService = analyticsService
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
        
        analyticsService.sendEvent("month_page_note_selected")
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
        
        analyticsService.sendEvent("month_page_day_rate_selected")
    }
    
    func updateDataSource() {
        var dataSource: [MonthRecordsDataSource] = []
            
        dayService.getDays(of: month).forEach { day in
            guard !day.isEmpty else { return }
            
            dataSource.append(
                .header(
                    viewModel: DayHeaderViewModel(
                        title: day.date?.dateShortRepresentation ?? "",
                        rate: day.rate,
                        action: { [weak self] in self?.openDayRate(day: day)}
                    )
                )
            )
            
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
                        dataSource.append(
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
            
            dataSource.append(
                .actions(
                    viewModel: DayActionsViewModel(
                        rate: day.rate,
                        rateAction: { [weak self] in self?.openDayRate(day: day)},
                        addNoteAction: { [weak self] in self?.openNote(day: day, noteRecord: nil)}
                    )
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
        analyticsService.sendEvent("month_page_loaded")
    }
}

extension MonthRecordsPresenter: CalendarDelegate {
    func update() {
        updateDataSource()
        delegate?.update()
    }
}
