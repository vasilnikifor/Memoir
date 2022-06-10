import UIKit

protocol DayRecordsPresenterProtocol {
    func viewLoaded()
    func rateDayTapped()
    func addNoteTapped()
}

final class DayRecordsPresenter {
    private weak var view: DayRecordsViewControllerProtocol?
    private let dayService: DayServiceProtocol
    private let analyticsService: AnalyticsServiceProtocol
    private weak var delegate: CalendarDelegate?
    private let date: Date
    private var day: Day?
    
    init(
        view: DayRecordsViewControllerProtocol,
        dayService: DayServiceProtocol,
        analyticsService: AnalyticsServiceProtocol,
        inputModel: DayRecordsInputModel
    ) {
        self.view = view
        self.dayService = dayService
        self.analyticsService = analyticsService
        delegate = inputModel.delegate
        date = inputModel.date
        day = inputModel.day
    }
    
    private func openNote(_ noteRecord: NoteRecord?) {
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
    
    private func updateDataSource() {
        day = dayService.getDay(date: date)
        
        let dataSource:  [DayRecordsDataSource]
        if let records = day?.records {
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
                                text: noteRecord.text ?? "",
                                time: (noteRecord.time ?? Date()).timeRepresentation,
                                action: { [weak self, weak noteRecord] in self?.openNote(noteRecord)}
                            )
                        )
                    } else {
                        return nil
                    }
                }
        } else {
            dataSource = []
        }
        
        view?.update(rate: day?.rate, dataSource: dataSource)
    }
}

extension DayRecordsPresenter: DayRecordsPresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(title: date.dateRepresentation)
        updateDataSource()
        analyticsService.sendEvent("day_page_loaded")
    }
    
    func rateDayTapped() {
        analyticsService.sendEvent("day_page_rate_day_tapped")
        view?.present(
            DayRateAssembler.assemble(
                DayRateInputModel(
                    date: date,
                    selectedRate: day?.rate,
                    delegate: self
                )
            )
        )
    }
    
    func addNoteTapped() {
        analyticsService.sendEvent("day_page_rate_add_note_tapped")
        openNote(nil)
    }
}


extension DayRecordsPresenter: CalendarDelegate {
    func update() {
        updateDataSource()
        delegate?.update()
    }
}
