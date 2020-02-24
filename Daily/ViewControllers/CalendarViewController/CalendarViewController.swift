import UIKit

protocol CalendarDelegate {
    func update()
}

final class CalendarViewController: UIViewController {
    @IBOutlet private weak var monthLabel: LargePrimaryLabel!
    @IBOutlet private weak var weekdaysCollectionView: UICollectionView!
    @IBOutlet private weak var calendarCollectionView: UICollectionView!
    
    private var month = Date().firstDayOfMonth
    private let weekdaysNames: [String] = Calendar.current.shortWeekdaySymbols
    private var calendarDataSours: [CalendarCellTypes] = []
    private let minimumInteritemSpacing: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        weekdaysCollectionView.delegate = self
        weekdaysCollectionView.dataSource = self
        weekdaysCollectionView.register(WeekdayCollectionViewCell.nib, forCellWithReuseIdentifier: WeekdayCollectionViewCell.nibName)
        
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.register(CalendarInactiveDayCollectionViewCell.nib, forCellWithReuseIdentifier: CalendarInactiveDayCollectionViewCell.nibName)
        calendarCollectionView.register(CalendarActiveDayCollectionVIewCell.nib, forCellWithReuseIdentifier: CalendarActiveDayCollectionVIewCell.nibName)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToNextMonth))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToPreviousMonth))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTransparencyOnNavigationController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setDefaultTransparenceOnNavigationController()
    }
}

// MARK: - Actions
extension CalendarViewController {
    @IBAction func tapToPreviousMonth(_ sender: Any) {
        handelChangeMonth(by: -1)
    }
    
    @IBAction func tapToNextMonth(_ sender: Any) {
        handelChangeMonth(by: 1)
    }
}

// MARK: - Private methods
extension CalendarViewController {
    private func setTransparencyOnNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setDefaultTransparenceOnNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func handelChangeMonth(by: Int) {
        month = month.addMonths(by)
        update()
    }
    
    @objc
    private func swipeToPreviousMonth() {
        handelChangeMonth(by: -1)
    }
    
    @objc
    private func swipeToNextMonth() {
        handelChangeMonth(by: 1)
    }
}


// MARK: - CalendarDelegate
extension CalendarViewController: CalendarDelegate {
    func update() {
        monthLabel.text = month.monthRepresentation
        
        calendarDataSours = CalendarCellFactory.configure(month: month)
        calendarCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case calendarCollectionView:
            switch calendarDataSours[indexPath.row] {
            case .activeDay(let viewModel):
                let dayRecordsList = DayRecordsListViewController.loadFromNib()
                dayRecordsList.configure(date: viewModel.date, delegate: self)
                push(dayRecordsList)
            default:
                break
            }
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case weekdaysCollectionView:
            return weekdaysNames.count
        case calendarCollectionView:
            return calendarDataSours.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case weekdaysCollectionView:
            let weekdayCell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekdayCollectionViewCell.nibName, for: indexPath) as! WeekdayCollectionViewCell
            weekdayCell.configure(weekdayName: weekdaysNames[indexPath.row])
            return weekdayCell
        case calendarCollectionView:
            switch calendarDataSours[indexPath.row] {
            case .inactiveDay(let viewModel):
                let inactivDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarInactiveDayCollectionViewCell.nibName, for: indexPath) as! CalendarInactiveDayCollectionViewCell
                inactivDayCell.configure(viewModel)
                return inactivDayCell
            case .activeDay(let viewModel):
                let activDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarActiveDayCollectionVIewCell.nibName, for: indexPath) as! CalendarActiveDayCollectionVIewCell
                activDayCell.configure(viewModel)
                return activDayCell
            }
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let spacingWidth = minimumInteritemSpacing * CGFloat(weekdaysNames.count - 1)
        let edge = (collectionViewWidth - spacingWidth) / CGFloat(weekdaysNames.count)
        return CGSize(width: edge, height: edge)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}
