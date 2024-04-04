import UIKit

protocol CalendarViewDelegate: AnyObject {
    func getMonthsWeekDays() -> [CalendarWeekdayViewModel]
    func getMonthsDays(month: Date) -> [CalendarDayViewConfiguration]
    func monthSelected(month: Date)
}

struct CalendarViewConfiguration {
    let month: Date
    let isBackgroundBlurred: Bool
    let previousMonthAccessibilityLabel: String
    let nextMonthAccessibilityLabel: String
    weak var delegate: CalendarViewDelegate?
}

final class CalendarView: UIView {
    weak var delegate: CalendarViewDelegate?
    var month: Date = .init()
    let pageCount: CGFloat = 3
    var previousMonthView = CalendarMonthView()
    var currentMonthView = CalendarMonthView()
    var nextMonthView = CalendarMonthView()

    let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        view.isVisible = false
        view.layer.cornerRadius = .m
        view.clipsToBounds = true
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()

    let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .m
        view.clipsToBounds = true
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.backgroundColor = .dLayeredForeground
        return view
    }()

    lazy var hatView: CalendarHatView = {
        let view = CalendarHatView()
        view.onNextMonthTap = { [weak self] in self?.swipeCalendarToNextMonth() }
        view.onPreviousMonthTap = { [weak self] in self?.swipeCalendarToPreviousMonth() }
        view.onCurrentMonthTap = { [weak self] in self?.showMonth() }
        return view
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        let pageSize = scrollView.frame.size
        let pagesWidth = pageSize.width * pageCount
        scrollView.contentSize = CGSize(width: pagesWidth, height: pageSize.height)
        scrollView.contentOffset = CGPoint(x: pageSize.width, y: .zero)
        update()
        layoutCalendar()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        addSubview(blurView)
        addSubview(cardView)
        addSubview(hatView)
        addSubview(scrollView)

        cardView
            .topToSuperview()
            .trailingToSuperview()
            .leadingToSuperview()
            .bottomToSuperview()

        blurView
            .topToSuperview()
            .trailingToSuperview()
            .leadingToSuperview()
            .bottomToSuperview()

        scrollView.addSubview(previousMonthView)
        scrollView.addSubview(currentMonthView)
        scrollView.addSubview(nextMonthView)

        hatView
            .topToSuperview(.m)
            .trailingToSuperview(-.m)
            .leadingToSuperview(.m)

        scrollView
            .top(to: hatView, anchor: hatView.bottomAnchor, offset: .m)
            .trailingToSuperview(-.m)
            .leadingToSuperview(.m)
            .bottomToSuperview(-.m)
            .widthToHeight(of: scrollView)
    }

    func layoutCalendar() {
        layoutMonthView(previousMonthView, onPage: 0)
        layoutMonthView(currentMonthView, onPage: 1)
        layoutMonthView(nextMonthView, onPage: 2)
    }

    func layoutMonthView(_ monthView: CalendarMonthView, onPage pageNumber: CGFloat) {
        let pageSize = scrollView.frame.size
        monthView.frame = CGRect(
            x: pageSize.width * pageNumber,
            y: .zero,
            width: pageSize.width,
            height: pageSize.height
        )
    }

    func fillMonthView(_ monthView: CalendarMonthView, month: Date, completion: (() -> Void)? = nil) {
        monthView.setup(with: CalendarMonthViewModel(month: month, delegate: delegate)) {
            completion?()
        }
    }

    @objc
    func swipeCalendarToNextMonth() {
        let pageSize = scrollView.frame.size
        let lastPageIndex: CGFloat = pageCount - 1
        let contentOffset = CGPoint(x: pageSize.width * lastPageIndex, y: .zero)
        scrollView.setContentOffset(contentOffset, animated: true)
    }

    @objc
    func swipeCalendarToPreviousMonth() {
        let contentOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }

    @objc
    func showNextMonth() {
        month = month.addMonths(1)
        hatView.currentMonthButtonTitle = month.monthRepresentation
        let newNextMonthView = previousMonthView
        previousMonthView = currentMonthView
        currentMonthView = nextMonthView
        nextMonthView = newNextMonthView
        fillMonthView(newNextMonthView, month: month.addMonths(1))
        layoutCalendar()
    }

    @objc
    func showPreviousMonthView() {
        month = month.addMonths(-1)
        hatView.currentMonthButtonTitle = month.monthRepresentation
        let newPreviousMonthView = nextMonthView
        nextMonthView = currentMonthView
        currentMonthView = previousMonthView
        previousMonthView = newPreviousMonthView
        fillMonthView(newPreviousMonthView, month: month.addMonths(-1))
        layoutCalendar()
    }

    @objc
    func showMonth() {
        delegate?.monthSelected(month: month)
    }
}

extension CalendarView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let pageXOffset = scrollView.frame.size.width

        if offsetX > scrollView.frame.size.width * 1.5 {
            showNextMonth()
            scrollView.contentOffset.x -= pageXOffset
        }

        if offsetX < scrollView.frame.size.width * 0.5 {
            showPreviousMonthView()
            scrollView.contentOffset.x += pageXOffset
        }
    }
}

extension CalendarView {
    func update(completion: (() -> Void)? = nil) {
        hatView.currentMonthButtonTitle = month.monthRepresentation

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        fillMonthView(previousMonthView, month: month.addMonths(-1)) {
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        fillMonthView(currentMonthView, month: month) {
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        fillMonthView(nextMonthView, month: month.addMonths(1)) {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            completion?()
        }
    }
}

extension CalendarView: Configurable {
    func configure(with configuration: CalendarViewConfiguration) {
        month = configuration.month
        hatView.previousMonthAccessibilityLabel = configuration.previousMonthAccessibilityLabel
        hatView.nextMonthAccessibilityLabel = configuration.nextMonthAccessibilityLabel
        delegate = configuration.delegate
        blurView.isVisible = configuration.isBackgroundBlurred
        cardView.isVisible = !configuration.isBackgroundBlurred
        update()
    }
}
