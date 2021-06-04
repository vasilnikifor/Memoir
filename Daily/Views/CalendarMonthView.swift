import UIKit

struct CalendarMonthViewModel {
    let month: Date
}

final class CalendarMonthView: UIView {
    private var month: Date
    private let columnsCount: CGFloat = 7
    private let maxWeeksInMonth: Int = 6
    private let shortMonthWeeks: Int = 4
    private let mediumMonthWeeks: Int = 5
    
    private lazy var weekdaysCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.registerCell(type: MonthWeekdayViewCell.self, cellSource: .code)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private lazy var calendarCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.registerCell(type: MonthDayViewCell.self, cellSource: .code)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addSubview(weekdaysCollectionView)
        addSubview(calendarCollectionView)

        weekdaysCollectionView
            .topToSuperview()
            .horizontalEdges()
            .height(to: calendarCollectionView, multiplier: 1 / (columnsCount - 1))

        calendarCollectionView
            .topToBottom(of: weekdaysCollectionView)
            .horizontalEdges()
            .bottomToSuperview()
        
        widthToHeight(of: self)

        update()
    }
}

extension CalendarMonthView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case calendarCollectionView:
            let day = monthDaysDataSours[indexPath.row]

            guard day.isAvalibleDate else {
                delegate?.disabledDateDidTap(day.date)
                return
            }

            if let availableDates = availableDates, availableDates.contains(day.date) {
                delegate?.dataDidSelect(date: day.date)
            } else if availableDates == nil {
                delegate?.dataDidSelect(date: day.date)
            }
        default:
            break
        }
    }
}

extension CalendarMonthView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case weekdaysCollectionView:
            return weekdaysNames.count
        case calendarCollectionView:
            return monthDaysDataSours.count
        default:
            return .zero
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case weekdaysCollectionView:
            let cell = collectionView.dequeueReusableCell(type: MonthWeekdayViewCell.self, indexPath: indexPath)
            cell.setup(with: MonthWeekdayViewModel(text: weekdaysNames[indexPath.row]))
            return cell
        case calendarCollectionView:
            let cell = collectionView.dequeueReusableCell(type: MonthDayViewCell.self, indexPath: indexPath)
            cell.setup(with: monthDaysDataSours[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension CalendarMonthView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellEdgeSize = collectionView.frame.width / columnsCount
        return CGSize(
            width: cellEdgeSize,
            height: cellEdgeSize
        )
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch month.numberOfWeeksInMonth {
        case shortMonthWeeks:
            let freeLines = CGFloat(maxWeeksInMonth - shortMonthWeeks)
            let linesSpaces = CGFloat(shortMonthWeeks - 1)
            return cellEdgeSize * freeLines / linesSpaces
        case mediumMonthWeeks:
            let freeLines = CGFloat(maxWeeksInMonth - mediumMonthWeeks)
            let linesSpaces = CGFloat(mediumMonthWeeks - 1)
            return cellEdgeSize * freeLines / linesSpaces
        default:
            return .zero
        }
    }
}

extension CalendarMonthView {
    func setup(with viewModel: CalendarMonthViewModel) {
        month = viewModel.month
        backgroundColor = UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
