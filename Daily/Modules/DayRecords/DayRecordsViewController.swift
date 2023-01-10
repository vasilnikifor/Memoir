import UIKit

protocol DayRecordsViewControllerProtocol: AnyObject {
    func setupInitialState(title: String)
    func update(rate: DayRate?, dataSource: [DayRecordsDataSource])
}

final class DayRecordsViewController: UIViewController {
    var presenter: DayRecordsPresenterProtocol?
    var dataSource: [DayRecordsDataSource] = []

    lazy var rateDayBarButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: Theme.rateDayImage,
            style: .plain,
            target: self,
            action: #selector(rateDateButtonTouchUpInside)
        )
    }()

    lazy var rateDayButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.rateDayImage, for: .normal)
        button.addTarget(self, action: #selector(rateDateButtonTouchUpInside), for: .touchUpInside)
        return button
    }()

    lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.addNoteImage, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTouchUpInside), for: .touchUpInside)
        return button
    }()

    lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Theme.backgroundColor
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(rateDayButton)
        stackView.addArrangedSubview(addNoteButton)
        return stackView
    }()

    lazy var tableView: UITableView = {
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

    func setup() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(actionsStackView)
        view.addSubview(tableView)

        actionsStackView
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview(safeArea: true)
            .height(.xxl)

        tableView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottom(to: actionsStackView, anchor: actionsStackView.topAnchor)
    }

    @objc
    func rateDateButtonTouchUpInside() {
        presenter?.rateDayTapped()
    }

    @objc
    func addNoteButtonTouchUpInside() {
        presenter?.addNoteTapped()
    }
}

extension DayRecordsViewController: DayRecordsViewControllerProtocol {
    func setupInitialState(title: String) {
        self.title = title
    }

    func update(rate: DayRate?, dataSource: [DayRecordsDataSource]) {
        if rate != nil {
            rateDayBarButton.image = rate.image
            rateDayBarButton.tintColor = rate.tintColor
            navigationItem.rightBarButtonItem = rateDayBarButton
        } else {
            navigationItem.rightBarButtonItem = nil
        }
        rateDayButton.setImage(rate.image, for: .normal)
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
            return tableView.dequeueReusableCell(NoteRecordView.self, viewModel: viewModel)
        }
    }
}
