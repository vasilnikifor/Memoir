import UIKit

protocol CalendarViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(calendarModel: CalendarViewModel)
    func update(yesterdayConsoleModel: YesterdayConsoleView.Model?, todaysConsoleModel: TodayConsoleView.Model)
}

final class CalendarViewController: UIViewController {
    var presenter: CalendarPresenterProtocol?

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .m
        stackView.addArrangedSubview(calendarView)
        stackView.addArrangedSubview(yesterdayConsole)
        stackView.addArrangedSubview(todayConsole)
        stackView.layoutMargins = UIEdgeInsets(top: .m, left: .zero, bottom: .m, right: .zero)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let calendarView: CalendarView = {
        CalendarView()
    }()

    let yesterdayConsole: YesterdayConsoleView = {
        YesterdayConsoleView()
    }()
    
    let todayConsole: TodayConsoleView = {
        TodayConsoleView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setup() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView
            .topToSuperview()
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .bottomToSuperview()

        stackView
            .leadingToSuperview(safeArea: false)
            .trailingToSuperview(safeArea: false)
            .topToSuperview(safeArea: false)
            .bottomToSuperview(relation: .lessThanOrEqual, safeArea: false)
            .width(to: scrollView)
    }
}

extension CalendarViewController: CalendarViewControllerProtocol {
    func setupInitialState(calendarModel: CalendarViewModel) {
        calendarView.setup(with: calendarModel)
    }

    func update(
        yesterdayConsoleModel: YesterdayConsoleView.Model?,
        todaysConsoleModel: TodayConsoleView.Model
    ) {
        calendarView.update() { [weak self] in
            self?.todayConsole.setup(with: todaysConsoleModel)
            self?.yesterdayConsole.isHidden = yesterdayConsoleModel == nil
            if let yesterdayConsoleModel = yesterdayConsoleModel {
                self?.yesterdayConsole.setup(with: yesterdayConsoleModel)
            }
        }
    }
}


