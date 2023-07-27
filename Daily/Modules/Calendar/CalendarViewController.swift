import UIKit

protocol CalendarViewControllerProtocol: AnyObject {
    func setupInitialState(
        calendarModel: CalendarViewConfiguration,
        backgroundImage: UIImage?
    )
    func update(
        yesterdayConsoleModel: RateConsoleView.Configuration?,
        todaysConsoleModel: RateConsoleView.Configuration?,
        addNoteConsole: NoteConsoleView.Configuration
    )
}

extension CalendarViewController {
    enum Appearance {
        static let animationDuration: CGFloat = 0.2
    }
}

final class CalendarViewController: UIViewController {
    var presenter: CalendarPresenterProtocol?

    lazy var stackView: UIStackView = {
        let arrangedSubviews = [
            calendarView,
            yesterdayRateConsoleView,
            todayRateConsoleView,
            addNoteConsoleView,
        ]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = .m
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

    let yesterdayRateConsoleView: RateConsoleView = {
        RateConsoleView()
    }()

    let todayRateConsoleView: RateConsoleView = {
        RateConsoleView()
    }()

    let addNoteConsoleView: NoteConsoleView = {
        NoteConsoleView()
    }()

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        view.backgroundColor = Theme.layeredBackground
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        backgroundImageView
            .topToSuperview(safeArea: false)
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview(safeArea: false)

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
    func setupInitialState(
        calendarModel: CalendarViewConfiguration,
        backgroundImage: UIImage?
    ) {
        navigationItem.backButtonTitle = " "
        calendarView.configure(with: calendarModel)
        backgroundImageView.image = backgroundImage
    }

    func update(
        yesterdayConsoleModel: RateConsoleView.Configuration?,
        todaysConsoleModel: RateConsoleView.Configuration?,
        addNoteConsole: NoteConsoleView.Configuration
    ) {
        calendarView.update() { [weak self] in
            guard let self else { return }

            self.yesterdayRateConsoleView.isHidden = yesterdayConsoleModel == nil
            self.todayRateConsoleView.isHidden = todaysConsoleModel == nil
            self.addNoteConsoleView.configure(with: addNoteConsole)

            if let yesterdayConsoleModel {
                self.yesterdayRateConsoleView.configure(with: yesterdayConsoleModel)
            }

            if let todaysConsoleModel {
                self.todayRateConsoleView.configure(with: todaysConsoleModel)
            }

            UIView.animate(
                withDuration: Appearance.animationDuration,
                delay: .zero,
                animations: { self.view.layoutIfNeeded() }
            )
        }
    }
}
