import UIKit

struct CalendarMonthViewModel {
    let month: Date
    weak var delegate: CalendarViewDelegate?
}

final class CalendarMonthView: UIView {
    private let columnsCount: CGFloat = 7
    private let rowsCount: CGFloat = 7
    private let maxWeeksInMonth: Int = 6
    private let shortMonthWeeks: Int = 4
    private let mediumMonthWeeks: Int = 5
    private var weekdaysDataSource: [CalendarWeekdayViewModel] = []
    private var daysDataSource: [CalendarDayViewConfiguration] = []
    private var month: Date = .init()
    private weak var delegate: CalendarViewDelegate?
    private var weekdaysTopConstraint: NSLayoutConstraint?

    private lazy var weekdaysCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(CalendarWeekdayViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var calendarCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(CalendarDayViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let daysCount = daysDataSource.count
        let isFourWeeksMonth = daysCount == 28
        let isFiveWeeksMonth = daysCount == 35
        if isFourWeeksMonth {
            weekdaysTopConstraint?.constant = weekdaysCollectionView.frame.height
        } else if isFiveWeeksMonth {
            weekdaysTopConstraint?.constant = weekdaysCollectionView.frame.height / 2
        } else {
            weekdaysTopConstraint?.constant = .zero
        }
    }

    private func setup() {
        addSubview(weekdaysCollectionView)
        addSubview(calendarCollectionView)

        weekdaysTopConstraint = weekdaysCollectionView.top(to: self, anchor: topAnchor)

        weekdaysCollectionView
            .trailingToSuperview()
            .leadingToSuperview()
            .height(to: self, multiplier: 1 / rowsCount)

        calendarCollectionView
            .top(to: weekdaysCollectionView, anchor: weekdaysCollectionView.bottomAnchor)
            .trailingToSuperview()
            .leadingToSuperview()
            .bottomToSuperview()

        update()
    }

    private func update(completion: (() -> Void)? = nil) {
        weekdaysDataSource = delegate?.getMonthsWeekDays() ?? []
        daysDataSource = delegate?.getMonthsDays(month: month) ?? []

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        weekdaysCollectionView.reloadData()
        weekdaysCollectionView.performBatchUpdates {
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        calendarCollectionView.reloadData()
        calendarCollectionView.performBatchUpdates {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            completion?()
        }
    }
}

extension CalendarMonthView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection _: Int
    ) -> Int {
        switch collectionView {
        case weekdaysCollectionView:
            return weekdaysDataSource.count
        case calendarCollectionView:
            return daysDataSource.count
        default:
            return .zero
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionView {
        case weekdaysCollectionView:
            let cell = collectionView.dequeueReusableCell(CalendarWeekdayViewCell.self, for: indexPath)
            cell.configure(with: weekdaysDataSource[indexPath.row])
            return cell
        case calendarCollectionView:
            let cell = collectionView.dequeueReusableCell(CalendarDayViewCell.self, for: indexPath)
            cell.configure(with: daysDataSource[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension CalendarMonthView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        var cellEdgeSize = collectionView.frame.width / columnsCount
        cellEdgeSize.round(.down)
        return CGSize(width: cellEdgeSize, height: cellEdgeSize)
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt _: Int
    ) -> CGFloat {
        return .zero
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumLineSpacingForSectionAt _: Int
    ) -> CGFloat {
        return .zero
    }
}

extension CalendarMonthView: Configurable {
    func configure(with viewModel: CalendarMonthViewModel) {
        setup(with: viewModel, completion: nil)
    }

    func setup(with viewModel: CalendarMonthViewModel, completion: (() -> Void)? = nil) {
        month = viewModel.month
        delegate = viewModel.delegate
        update {
            completion?()
        }
    }
}
