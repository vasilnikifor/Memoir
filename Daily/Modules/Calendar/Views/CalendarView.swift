import UIKit

protocol CalendarViewDelegate: AnyObject {
    func getMonthsWeekDays() -> [CalendarWeekdayViewModel]
    func getMonthsDays(month: Date) -> [CalendarDayViewModel]
    func monthSelected(month: Date)
}

struct CalendarViewModel {
    let month: Date
    weak var delegate: CalendarViewDelegate?
}

final class CalendarView: UIView {
    weak var delegate: CalendarViewDelegate?
    var month: Date = Date()
    let pageCount: CGFloat = 3
    let buttonEdgeSize: CGFloat = 32
    let upMonthButtonImage: UIImage? = UIImage(systemName: "arrow.right")
    let downMonthButtonImage: UIImage? = UIImage(systemName: "arrow.left")
    var previousMonthView = CalendarMonthView()
    var currentMonthView = CalendarMonthView()
    var nextMonthView = CalendarMonthView()
    
    lazy var upMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(upMonthButtonImage, for: .normal)
        button.addTarget(self, action: #selector(swipeCalendarToNextMonth), for: .touchUpInside)
        return button
    }()
    
    lazy var downMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(downMonthButtonImage, for: .normal)
        button.addTarget(self, action: #selector(swipeCalendarToPreviousMonth), for: .touchUpInside)
        return button
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.apply(style: .primaryBig)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMonth)))
        label.isUserInteractionEnabled = true
        return label
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
        addSubview(upMonthButton)
        addSubview(downMonthButton)
        addSubview(monthLabel)
        addSubview(scrollView)
        
        scrollView.addSubview(previousMonthView)
        scrollView.addSubview(currentMonthView)
        scrollView.addSubview(nextMonthView)
        
        downMonthButton
            .topToSuperview()
            .leading(to: scrollView, anchor: scrollView.leadingAnchor)
            .height(buttonEdgeSize)
            .width(buttonEdgeSize)
        
        upMonthButton
            .topToSuperview()
            .trailing(to: scrollView, anchor: scrollView.trailingAnchor)
            .height(buttonEdgeSize)
            .width(buttonEdgeSize)
        
        monthLabel
            .topToSuperview()
            .leading(to: downMonthButton, anchor: downMonthButton.trailingAnchor)
            .trailing(to: upMonthButton, anchor: upMonthButton.leadingAnchor)
            .height(buttonEdgeSize)
        
        scrollView
            .top(to: monthLabel, anchor: monthLabel.bottomAnchor, offset: 16)
            .trailingToSuperview()
            .leadingToSuperview()
            .bottomToSuperview()
            .widthToHeight(of: scrollView)
    }
    
    func layoutCalendar() {
        layoutMonthView(previousMonthView, onPage: 0)
        layoutMonthView(currentMonthView, onPage: 1)
        layoutMonthView(nextMonthView, onPage: 2)
    }
    
    func layoutMonthView(_ monthView: CalendarMonthView, onPage pageNubmer: CGFloat) {
        let pageSize = scrollView.frame.size
        monthView.frame = CGRect(
            x: pageSize.width * pageNubmer,
            y: .zero,
            width: pageSize.width,
            height: pageSize.height
        )
    }
    
    func fillMonthView(_ monthView: CalendarMonthView, month: Date) {
        monthView.setup(with:
            CalendarMonthViewModel(
                month: month,
                delegate: delegate
            )
        )
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
        monthLabel.text = month.monthRepresentation
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
        monthLabel.text = month.monthRepresentation
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
    func update() {
        monthLabel.text = month.monthRepresentation
        fillMonthView(previousMonthView, month: month.addMonths(-1))
        fillMonthView(currentMonthView, month: month)
        fillMonthView(nextMonthView, month: month.addMonths(1))
    }
}

extension CalendarView: ViewModelSettable {
    func setup(with viewModel: CalendarViewModel) {
        month = viewModel.month
        delegate = viewModel.delegate
        update()
    }
}
