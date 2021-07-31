import UIKit

protocol MonthRecordsViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(title: String)
    func update(dataSource: [MonthRecordsDataSource])
}

final class MonthRecordsViewController: UIViewController {
    var presenter: MonthRecordsPresenterProtocol?
    
    private var dataSource: [MonthRecordsDataSource] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(tableView)
        
        tableView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
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
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .dayHeader(viewModel: let viewModel):
            let cell = tableView.dequeueReusableCell(DayHeaderView.self)
            cell.setup(with: viewModel)
            return cell
        case .note(let viewModel):
            let cell = tableView.dequeueReusableCell(NoteRecordView.self)
            cell.setup(with: viewModel)
            return cell
        }
    }
}
