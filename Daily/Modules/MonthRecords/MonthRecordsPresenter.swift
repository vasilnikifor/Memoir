import UIKit

protocol MonthRecordsCoordinatorProtocol: AnyObject {
    func showDayNote(date: Date, note: NoteRecord?, delegate: CalendarDelegate?)
    func showDayRate(date: Date, rate: DayRate?, delegate: CalendarDelegate?)
}

protocol MonthRecordsPresenterProtocol {
    func viewLoaded()
    func searchTextDidChange(_ searchText: String?)
}

final class MonthRecordsPresenter {
    weak var view: MonthRecordsViewControllerProtocol?
    weak var delegate: CalendarDelegate?
    weak var coordinator: MonthRecordsCoordinatorProtocol?
    let dayService: DayServiceProtocol
    let analyticsService: AnalyticsServiceProtocol
    let cms: CmsProtocol
    let factory: MonthRecordsFactoryProtocol
    let month: Date
    var mode: MonthRecordsMode = .month
    var searchText: String? = nil
    var days: [Day] = []

    init(
        view: MonthRecordsViewControllerProtocol,
        coordinator: MonthRecordsCoordinatorProtocol,
        dayService: DayServiceProtocol,
        analyticsService: AnalyticsServiceProtocol,
        cms: CmsProtocol,
        factory: MonthRecordsFactoryProtocol,
        inputModel: MonthRecordsInputModel
    ) {
        self.view = view
        self.coordinator = coordinator
        self.dayService = dayService
        self.analyticsService = analyticsService
        self.cms = cms
        self.factory = factory
        month = inputModel.month
        delegate = inputModel.delegate
    }

    func updateView() {
        let dataSource: [MonthRecordsDataSource] = factory.makeDataSource(
            searchText: searchText,
            mode: mode,
            days: days,
            delegate: self
        )

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
        switch mode {
        case .month:
            days = dayService.getDays(month: month)
        case .year:
            days = dayService.getDays(year: month)
        }
        updateView()
        analyticsService.sendEvent("month_page_loaded")
    }

    func searchTextDidChange(_ searchText: String?) {
        self.searchText = searchText
        updateView()
    }
}

extension MonthRecordsPresenter: CalendarDelegate {
    func update() {
        switch mode {
        case .month:
            days = dayService.getDays(month: month)
        case .year:
            days = dayService.getDays(year: month)
        }
        updateView()
        delegate?.update()
    }
}

extension MonthRecordsPresenter: MonthRecordsFactoryDelegate {
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
}
