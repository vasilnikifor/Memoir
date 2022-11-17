import UIKit

protocol MonthRecordsViewControllerProtocol: Transitionable, AnyObject {
    func update(navigationTitleModel: NavigationTitleView.ViewModel, dataSource: [MonthRecordsDataSource])
    func showRangeSelection(_ actionSheet: ActionSheet)
}

final class MonthRecordsViewController: UIViewController {
    var presenter: MonthRecordsPresenterProtocol?
    var dataSource: [MonthRecordsDataSource] = []

    private let navigationTitleView: NavigationTitleView = {
        NavigationTitleView()
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setup()
    }
    
    func setup() {
        view.addSubview(tableView)
        view.backgroundColor = Theme.bottomLayerBackgroundColor
        navigationItem.titleView = navigationTitleView
        
        tableView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview(safeArea: false)
    }
}



extension MonthRecordsViewController: MonthRecordsViewControllerProtocol {
    func update(navigationTitleModel: NavigationTitleView.ViewModel, dataSource: [MonthRecordsDataSource]) {
        navigationTitleView.setup(with: navigationTitleModel)
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
        case .header(viewModel: let viewModel):
            return tableView.dequeueReusableCell(DayHeaderView.self, viewModel: viewModel)
        case .note(let viewModel):
            return tableView.dequeueReusableCell(DayNoteRecordView.self, viewModel: viewModel)
        case .actions(let viewModel):
            return tableView.dequeueReusableCell(DayActionsView.self, viewModel: viewModel)
        }
    }
}
