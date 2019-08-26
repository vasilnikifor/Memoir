import UIKit

class CalendarViewController: UIViewController {
    
    // MARK: - Methods
    
    func drawCalendar() {
        drawWeekDays()
        fillMonthLabel(month: month)
        drawCalendarDayButtons()
    }
    
    // MARK: - Private propertis
    
    private var month = Date().firstDayOfMonth()
    private var dayButtonMatch: [UIButton: Date] = [:]
    private let calendarDrawer = CalendarDrawer()
    
    // MARK: - Outlets
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet var weekDayLabel: [UILabel]!
    @IBOutlet var dayButtons: [UIButton]!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTransparencyOnNavigationController()
        
        drawCalendar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setDefaultTransparenceOnNavigationController()
    }
    
    // MARK: - Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openerDayView" {
            if let dayViewControllet = segue.destination as? DayViewController {
                dayViewControllet.dayDate = sender as? Date ?? Date()
                dayViewControllet.delegate = self
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setViewSettings() {
        addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        addSwipe(action: #selector(previousMonth), direction: .right)
        addSwipe(action: #selector(nextMonth), direction: .left)
    }
    
    private func setTransparencyOnNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setDefaultTransparenceOnNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func addSwipe(action: Selector, direction: UISwipeGestureRecognizer.Direction) {
        let swipe = UISwipeGestureRecognizer(target: self, action: action)
        swipe.direction = direction
        view.addGestureRecognizer(swipe)
    }
    
    private func handelChangeMonth(by: Int) {
        month = month.addMonths(by)
        drawCalendar()
    }

    private func drawCalendarDayButtons() {
        dayButtonMatch = [:]
        
        let daysOfMonth     = Day.getAllDaysOfMounth(month)
        let firstDayOfMonth = month.firstDayOfMonth()
        let lastDayOfMonth  = month.lastDayOfMonth()
        var drawingDay      = getFirstDrowingDay(firstDayOfMonth: firstDayOfMonth)
        
        var hideTheLastButtons = false
        
        for index in 0...dayButtons.count - 1 {
            let button = getButtonById(String(index))!
            
            button.isHidden = false
            
            var day: Day?
            var dayType: CalendarDrawer.DayType = .inactive
            
            if hideTheLastButtons {
                button.isHidden = true
                continue
            } else if drawingDay < firstDayOfMonth {
                
            } else if drawingDay > lastDayOfMonth {
                if (index == 28 || index == 35) {
                    hideTheLastButtons = true
                    button.isHidden = true
                    continue
                }
            } else {
                dayButtonMatch[button] = drawingDay
                day = getDay(daysOfMonth: daysOfMonth, date: drawingDay)
                dayType = (drawingDay == Date().getStartDay()) ? .today : .usual
            }
            calendarDrawer.drawDayButton(button, dayDate: drawingDay, dayType: dayType, day: day)
            
            drawingDay = drawingDay.addDays(1)
        }
    }
    
    private func getFirstDrowingDay(firstDayOfMonth: Date) -> Date {
        return firstDayOfMonth.addDays(-(Calendar.current.component(.weekday, from: firstDayOfMonth)-1)).getStartDay()
    }
    
    private func getDay(daysOfMonth: [Day], date: Date) -> Day? {
        for index in daysOfMonth.indices {
            if daysOfMonth[index].date == date.getStartDay() {
                return daysOfMonth[index]
            }
        }
        return nil
    }
    
    private func getButtonById(_ id: String) -> UIButton? {
        for index in dayButtons.indices {
            if dayButtons[index].restorationIdentifier == id {
                return dayButtons[index]
            }
        }
        return nil
    }
    
    private func fillMonthLabel(month: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        monthLabel.text = dateFormatter.string(from: month)
    }
    
    private func drawWeekDays() {
        for index in weekDayLabel.indices {
            let label = weekDayLabel[index]
            label.text = Calendar.current.shortWeekdaySymbols[index]
        }
    }
    
    @objc private func nextMonth() {
        handelChangeMonth(by: 1)
    }
    
    @objc private func previousMonth() {
        handelChangeMonth(by: -1)
    }
    
    // MARK: - Actions
    
    @IBAction func openDay(_ sender: UIButton) {
        performSegue(withIdentifier: "openerDayView", sender: dayButtonMatch[sender])
    }
    
    @IBAction func changeMonth(_ sender: UIButton) {
        if sender.restorationIdentifier == "previousMonth" {
            previousMonth()
        } else if sender.restorationIdentifier == "nextMonth" {
            nextMonth()
        }
    }
    
}

// MARK: - DayEditorDelegate
extension CalendarViewController: DayEditorDelegate {
    
    func dayChanged(_ dayDate: Date) {
        print(dayDate)
    }
    
}


