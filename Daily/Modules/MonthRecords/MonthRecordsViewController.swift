import UIKit

protocol MonthRecordsViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(title: String)
    func update(dataSource: [MonthRecordsDataSource])
}

final class MonthRecordsViewController: UIViewController {
    var presenter: MonthRecordsPresenterProtocol?
    var dataSource: [MonthRecordsDataSource] = []
    
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
        
        tableView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview(safeArea: false)
    }
}


extension MonthRecordsViewController: MonthRecordsViewControllerProtocol {
    func setupInitialState(title: String) {
        self.title = title
    }
    
    func update(dataSource: [MonthRecordsDataSource]) {
        self.dataSource = dataSource
        tableView.reloadData()
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
