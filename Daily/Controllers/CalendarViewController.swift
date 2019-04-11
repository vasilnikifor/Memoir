import UIKit

class CalendarViewController: UIViewController {

    var month = Date().firstDayOfMonth()
    var dayButtonMatch: [UIButton: Date] = [:]
    let calendarDrawer = CalendarDrawer.drawer
    
    @IBAction func changeMonth(_ sender: UIButton) {
        if sender.restorationIdentifier == "previousMonth" {
            previousMonth()
        } else if sender.restorationIdentifier == "nextMonth" {
            nextMonth()
        }
    }
    
    @IBAction func openDay(_ sender: UIButton) {
        
        
        
        performSegue(withIdentifier: "openDayView", sender: sender)
    }
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet var weekDayLabel: [UILabel]!
    @IBOutlet var dayButtons: [UIButton]!
    
    @IBOutlet weak var allPageView: UIView! {
        didSet {
            addGestureToAllPageView(target: self, selector: #selector(nextMonth), direction: .left)
            addGestureToAllPageView(target: self, selector: #selector(previousMonth), direction: .right)

        }
    }
    
    @objc func nextMonth() {
        handelChangeMonth(by: 1)
    }
    
    @objc func previousMonth() {
        handelChangeMonth(by: -1)
    }
    
    private func addGestureToAllPageView(target: Any?, selector: Selector, direction: UISwipeGestureRecognizer.Direction) {
        let swipe = UISwipeGestureRecognizer(target: target, action: selector)
        swipe.direction = direction
        allPageView.addGestureRecognizer(swipe)
    }
    
    private func handelChangeMonth(by: Int) {
        month = month.addMonths(by)
        drawCalendar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawCalendar()
    }
    
    private func drawCalendar() {
        drawWeekDays()
        fillMonthLabel(month: month)
        drawCalendarDayButtons()
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
            var dayType = "inactive"
            
            if hideTheLastButtons {
                button.isHidden = true
                continue
            } else if drawingDay < firstDayOfMonth {
                
            } else if drawingDay > lastDayOfMonth {
                if (index == 27 || index == 34) {
                    hideTheLastButtons = true
                }
            } else {
                dayButtonMatch[button] = drawingDay
                day = getDay(daysOfMonth: daysOfMonth, date: drawingDay)
                dayType = drawingDay == Date().getStartDay() ? "today" : "usual"
            }
            calendarDrawer.drawDayButton(button: button, dayDate: drawingDay, dayType: dayType, day: day)
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDayView" {
            let desitatonVC = segue.destination as! DayViewController
            desitatonVC.dayDate = dayButtonMatch[sender as! UIButton] ?? Date().getStartDay()
        }
    }
}


