import UIKit

protocol DayRecordsViewControllerProtocol: AnyObject {
    func setupInitialState(
        title: String
    )

    func update(
        rate: DayRate?,
        dataSource: [DayRecordsDataSource],
        emptyStateModel: EmptyStateView.Model?
    )
}

final class DayRecordsViewController: UIViewController {
    var presenter: DayRecordsPresenterProtocol?
    private var dataSource: [DayRecordsDataSource] = []

    private lazy var rateDayBarButton: UIBarButtonItem = .init(
        image: .rateDay,
        style: .plain,
        target: self,
        action: #selector(rateDateButtonTouchUpInside)
    )

    private lazy var rateDayButton: UIButton = {
        let button = UIButton()
        button.setImage(.rateDay, for: .normal)
        button.addTarget(self, action: #selector(rateDateButtonTouchUpInside), for: .touchUpInside)
        return button
    }()

    private lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(.addNote, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTouchUpInside), for: .touchUpInside)
        return button
    }()

    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .dBackground
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

    private let emptyStateView: EmptyStateView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setup()
    }

    private func setup() {
        view.backgroundColor = .dBackground
        view.addSubview(actionsStackView)
        view.addSubview(tableView)
        view.addSubview(emptyStateView)

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

        emptyStateView
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

    func update(
        rate: DayRate?,
        dataSource: [DayRecordsDataSource],
        emptyStateModel: EmptyStateView.Model?
    ) {
        if rate != nil {
            rateDayBarButton.image = rate.filledImage
            rateDayBarButton.tintColor = rate.tintColor
            navigationItem.rightBarButtonItem = rateDayBarButton
        } else {
            navigationItem.rightBarButtonItem = nil
            rateDayButton.setImage(rate.image, for: .normal)
            rateDayButton.tintColor = rate.tintColor
        }

        rateDayButton.setImage(rate.filledImage, for: .normal)
        rateDayButton.tintColor = rate.tintColor

        self.dataSource = dataSource
        tableView.reloadData()

        if let model = emptyStateModel {
            emptyStateView.isHidden = false
            emptyStateView.configure(with: model)
        } else {
            emptyStateView.isHidden = true
        }
    }
}

extension DayRecordsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.row] {
        case let .note(configuration):
            return tableView.dequeueReusableCell(NoteRecordView.self, configuration: configuration)
        }
    }
}
