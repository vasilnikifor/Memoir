import UIKit

protocol MonthRecordsViewControllerProtocol: AnyObject {
    func update(navigationTitleModel: NavigationTitleView.ViewModel, dataSource: [MonthRecordsDataSource])
    func showRangeSelection(_ actionSheet: ActionSheet)
}

final class MonthRecordsViewController: UIViewController {
    var presenter: MonthRecordsPresenterProtocol?
    var dataSource: [MonthRecordsDataSource] = []

    private let navigationTitleView: NavigationTitleView = {
        NavigationTitleView()
    }()

    private lazy var searchBarButtonItem: UIBarButtonItem = {
        UIBarButtonItem(
            image: Theme.searchImage,
            style: .plain,
            target: self,
            action: #selector(searchButtonDidTap)
        )
    }()

    private lazy var searchViewController: UISearchController = {
        let controller = UISearchController()
        controller.searchResultsUpdater = self
        controller.showsSearchResultsController = true
        return controller
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setup()
    }

    func setup() {
        view.addSubview(tableView)
        view.backgroundColor = Theme.layeredBackground
        navigationItem.titleView = navigationTitleView
        navigationItem.searchController = searchViewController
        navigationItem.rightBarButtonItem = searchBarButtonItem

        tableView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview(safeArea: false)
    }

    @objc
    private func searchButtonDidTap() {
        DispatchQueue.main.async {
            self.searchViewController.searchBar.becomeFirstResponder()
        }
    }
}

extension MonthRecordsViewController: MonthRecordsViewControllerProtocol {
    func update(navigationTitleModel: NavigationTitleView.ViewModel, dataSource: [MonthRecordsDataSource]) {
        navigationTitleView.configure(with: navigationTitleModel)
        self.dataSource = dataSource
        tableView.reloadData()
    }

    func showRangeSelection(_ actionSheet: ActionSheet) {
        let alert = UIAlertController(title: actionSheet.title, message: nil, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = navigationTitleView

        actionSheet.sheetActions.forEach { sheetActionItem in
            alert.addAction(
                UIAlertAction(
                    title: sheetActionItem.title,
                    style: sheetActionItem.style.alertActionStyle,
                    handler: { _ in sheetActionItem.action?() }
                )
            )
        }

        present(alert, animated: true)
    }
}

extension MonthRecordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .header(let configuration):
            return tableView.dequeueReusableCell(MonthRecordsHeaderView.self, configuration: configuration)
        case .note(let configuration):
            return tableView.dequeueReusableCell(MonthRecordsRecordView.self, configuration: configuration)
        case .actions(let configuration):
            return tableView.dequeueReusableCell(MonthRecordsFooterView.self, configuration: configuration)
        }
    }
}

extension MonthRecordsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.searchTextDidChange(searchController.searchBar.text)
    }
}