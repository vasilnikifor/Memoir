import UIKit

protocol MonthRecordsCoordinatorProtocol: AnyObject {
    func showDayNote(date: Date, note: NoteRecord?, delegate: CalendarDelegate?)
    func showDayRate(date: Date, rate: DayRate?, delegate: CalendarDelegate?)
    func share(url: URL, completion: (() -> Void)?)
}

protocol MonthRecordsPresenterProtocol {
    func viewLoaded()
    func moreDidTap()
    func searchTextDidChange(_ searchText: String?)
}

final class MonthRecordsPresenter {
    private weak var view: MonthRecordsViewControllerProtocol?
    private weak var delegate: CalendarDelegate?
    private weak var coordinator: MonthRecordsCoordinatorProtocol?
    private let dayService: DayServiceProtocol
    private let cms: CmsProtocol
    private let factory: MonthRecordsFactoryProtocol
    private let month: Date
    private var mode: MonthRecordsMode = .month
    private var searchText: String?
    private var days: [Day] = []

    init(
        view: MonthRecordsViewControllerProtocol,
        coordinator: MonthRecordsCoordinatorProtocol,
        dayService: DayServiceProtocol,
        cms: CmsProtocol,
        factory: MonthRecordsFactoryProtocol,
        inputModel: MonthRecordsInputModel
    ) {
        self.view = view
        self.coordinator = coordinator
        self.dayService = dayService
        self.cms = cms
        self.factory = factory
        month = inputModel.month
        delegate = inputModel.delegate
    }

    private func updateView() {
        let dataSource: [MonthRecordsDataSource] = factory.makeDataSource(
            searchText: searchText,
            mode: mode,
            days: days,
            delegate: self
        )

        let navigationTitleModel = NavigationTitleView.ViewModel(
            title: makeTitle(),
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
                        action: { [weak self] in self?.updateMode(.month) }
                    ),
                    ActionSheet.ActionSheetItem(
                        title: cms.home.wholeYear(year: month.yearRepresentation),
                        style: .default,
                        action: { [weak self] in self?.updateMode(.year) }
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

    private func updateMode(_ selectedMode: MonthRecordsMode) {
        mode = selectedMode
        switch mode {
        case .month:
            days = dayService.getDays(month: month)
        case .year:
            days = dayService.getDays(year: month)
        }
        updateView()
    }

    private func shareNotes() {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let directory = documentDirectories.first else { return }
        let title = makeTitle()
        let text = factory.makeSharingText(days: days)
        let path = directory.appendingPathComponent("\(title).rtf")
        let file = try? text.data(
            from: .init(location: .zero, length: text.length),
            documentAttributes: [
                .documentType: NSAttributedString.DocumentType.rtf,
                .characterEncoding: String.Encoding.utf8,
            ]
        )
        try? file?.write(to: path)
        coordinator?.share(url: path) {
            try? FileManager.default.removeItem(at: path)
        }
    }

    private func searchNotes() {
        view?.showSearch()
    }

    private func makeTitle() -> String {
        switch mode {
        case .month:
            return month.monthRepresentation
        case .year:
            return cms.home.wholeYear(year: month.yearRepresentation)
        }
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
    }

    func searchTextDidChange(_ newSearchText: String?) {
        searchText = newSearchText
        updateView()
    }

    func moreDidTap() {
        view?.showRangeSelection(
            ActionSheet(
                sheetActions: [
                    ActionSheet.ActionSheetItem(
                        title: cms.common.search,
                        icon: .search,
                        style: .default,
                        action: { [weak self] in self?.searchNotes() }
                    ),
                    ActionSheet.ActionSheetItem(
                        title: cms.common.share,
                        icon: .share,
                        style: .default,
                        action: { [weak self] in self?.shareNotes() }
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
    }

    func openDayRate(day: Day) {
        guard let date = day.date else { return }
        coordinator?.showDayRate(date: date, rate: day.rate, delegate: self)
    }
}
