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
        tableView.delegate = self
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
        view.backgroundColor = Theme.topLayerBackgroundColor
        view.addSubview(tableView)
        view.backgroundColor = Theme.bottomLayerBackgroundColor
        
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

extension MonthRecordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(DayHeaderView.self, viewModel: dataSource[section].sectionHeaderViewModel)
    }
}

extension MonthRecordsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].sectionDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section].sectionDataSource[indexPath.row] {
        case .note(let viewModel):
            return tableView.dequeueReusableCell(DayNoteRecordView.self, viewModel: viewModel)
        case .actions(let viewModel):
            return tableView.dequeueReusableCell(DayActionsView.self, viewModel: viewModel)
        }
    }
}
