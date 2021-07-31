import UIKit

protocol DayRecordsViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(title: String)
    func update(rateImage: UIImage, dataSource: [DayRecordsDataSource])
}

final class DayRecordsViewController: UIViewController {
    var presenter: DayRecordsPresenterProtocol?
    
    private var dataSource: [DayRecordsDataSource] = []
    
    private lazy var rateDayButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.rateDayImage, for: .normal)
        button.addTarget(self, action: #selector(rateDateButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.addNoteImage, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Theme.backgroundColor
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(rateDayButton)
        stackView.addArrangedSubview(addNoteButton)
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(actionsStackView)
        view.addSubview(tableView)
        
        actionsStackView
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview(safeArea: true)
            .height(48)
        
        tableView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottom(to: actionsStackView, anchor: actionsStackView.topAnchor)
    }
    
    @objc
    private func rateDateButtonTouchUpInside() {
        presenter?.rateDayTapped()
    }
    
    @objc
    private func addNoteButtonTouchUpInside() {
        presenter?.addNoteTapped()
    }
}

extension DayRecordsViewController: DayRecordsViewControllerProtocol {
    func setupInitialState(title: String) {
        self.title = title
    }
    
    func update(rateImage: UIImage, dataSource: [DayRecordsDataSource]) {
        rateDayButton.setImage(rateImage, for: .normal)
        self.dataSource = dataSource
        tableView.reloadData()
    }
}

extension DayRecordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case .note(let viewModel):
            let cell = tableView.dequeueReusableCell(NoteRecordView.self)
            cell.setup(with: viewModel)
            return cell
        }
    }
}
