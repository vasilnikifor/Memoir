import UIKit

protocol MonthRecordsCoordinatorProtocol: AnyObject {
    func showDayNote(date: Date, note: NoteRecord?, delegate: CalendarDelegate?)
    func showDayRate(date: Date, rate: DayRate?, delegate: CalendarDelegate?)
}

protocol MonthRecordsPresenterProtocol {
    func viewLoaded()
}

extension MonthRecordsPresenter {
    enum Mode {
        case month
        case year
    }
}

final class MonthRecordsPresenter {
    weak var view: MonthRecordsViewControllerProtocol?
    weak var delegate: CalendarDelegate?
    weak var coordinator: MonthRecordsCoordinatorProtocol?
    let dayService: DayServiceProtocol
    let analyticsService: AnalyticsServiceProtocol
    let cms: CmsProtocol
    let month: Date
    var mode: Mode = .month
    
    init(
        view: MonthRecordsViewControllerProtocol,
        coordinator: MonthRecordsCoordinatorProtocol,
        dayService: DayServiceProtocol,
        analyticsService: AnalyticsServiceProtocol,
        cms: CmsProtocol,
        inputModel: MonthRecordsInputModel
    ) {
        self.view = view
        self.coordinator = coordinator
        self.dayService = dayService
        self.analyticsService = analyticsService
        self.cms = cms
        month = inputModel.month
        delegate = inputModel.delegate
    }
    
    func openNote(day: Day, noteRecord: NoteRecord?) {
        guard let date = day.date else { return }
        coordinator?.showDayNote(date: date, note: noteRecord, delegate: self)
        analyticsService.sendEvent("month_page_note_selected")
    }
    
    func openDayRate(day: Day) {
        guard let date = day.date else { return }
        coordinator?.showDayRate(date: date, rate: day.rate, delegate: self)
        analyticsService.sendEvent("month_page_day_rate_selected")
    }
    
    func updateView() {
        var dataSource: [MonthRecordsDataSource] = []
        var days: [Day] = []
        
        switch mode {
        case .month:
            days = dayService.getDays(month: month)
        case .year:
            days = dayService.getDays(year: month)
        }
        
        days.forEach { day in
            guard !day.isEmpty else { return }

            let title: String
            switch mode {
            case .month:
                title = day.date?.dateShortRepresentation ?? ""
            case .year:
                title = day.date?.dateRepresentation ?? ""
            }

            dataSource.append(
                .header(
                    viewModel: DayHeaderViewModel(
                        title: title,
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
        
        let navigationTitle: String
        switch mode {
        case .month:
            navigationTitle = month.monthRepresentation
        case .year:
            navigationTitle = cms.home.wholeYear(year: month.yearRepresentation)
        }
        let navigationTitleModel = NavigationTitleView.ViewModel(
            title: navigationTitle,
            action: { [weak self] in self?.selectMode() }
        )
        
        view?.update(
            navigationTitleModel: navigationTitleModel,
            dataSource: dataSource
        )
    }

    private func selectMode() {
        view?.showRangeSelection(
            ActionSheet(
                title: cms.home.selectDateRange,
                sheetActions: [
                    ActionSheet.ActionSheetItem(
                        title: month.monthRepresentation,
                        style: .default,
                        action: { [weak self] in
                            self?.mode = .month
                            self?.updateView()
                        }
                    ),
                    ActionSheet.ActionSheetItem(
                        title: cms.home.wholeYear(year: month.yearRepresentation),
                        style: .default,
                        action: { [weak self] in
                            self?.mode = .year
                            self?.updateView()
                        }
                    ),
                    ActionSheet.ActionSheetItem(
                        title: cms.common.cancel,
                        style: .cancel,
                        action: nil
                    )
                ]
            )
        )
    }
}

extension MonthRecordsPresenter: MonthRecordsPresenterProtocol {
    func viewLoaded() {
        updateView()
        analyticsService.sendEvent("month_page_loaded")
    }
}

extension MonthRecordsPresenter: CalendarDelegate {
    func update() {
        updateView()
        delegate?.update()
    }
}
