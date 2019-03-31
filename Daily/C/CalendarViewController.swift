import UIKit

class CalendarViewController: UIViewController {

    var month = Date().firstDayOfMonth()
    
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
    
    @IBOutlet weak var calendarView: UIStackView!{
        didSet {
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(nextMonth))
            swipeLeft.direction = .left
            calendarView.addGestureRecognizer(swipeLeft)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(previousMonth))
            swipeRight.direction = .right
            calendarView.addGestureRecognizer(swipeRight)
        }
    }
    
    @objc func nextMonth() {
        handelChangeMonth(by: 1)
    }
    
    @objc func previousMonth() {
        handelChangeMonth(by: -1)
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

        let daysOfMonth = Day.getAllDaysOfMounth(month)
        
        let firstDayOfMonth = month.firstDayOfMonth()
        let lastDayOfMonth  = month.lastDayOfMonth()
        var drowingDay      = firstDayOfMonth.addDays(-(Calendar.current.component(.weekday, from: firstDayOfMonth)-1)).getStartDay()
        
        var hideTheLastButtons = false
        
        for index in 0...dayButtons.count - 1 {
            let button = getButtonById(String(index))!
            
            button.isHidden = false
            
            if drowingDay < firstDayOfMonth {
                drawInactiveDayButton(button: button, day: drowingDay)
            } else if drowingDay > lastDayOfMonth {
                drawInactiveDayButton(button: button, day: drowingDay)
                if (index == 28 || index == 35) {
                    hideTheLastButtons = true
                }
            } else {
                drawDayButtonOfCurrentMonth(button: button,
                                            day: drowingDay,
                                            objDay: getDay(daysOfMonth: daysOfMonth, date: drowingDay))
            }
            
            if hideTheLastButtons {
                button.isHidden = true
                continue
            }
            
            drowingDay = drowingDay.addDays(1)
        }
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
        if weekDayLabel != nil {
            for index in weekDayLabel.indices {
                let label = weekDayLabel[index]
                label.text = Calendar.current.shortWeekdaySymbols[index]
            }
        }
    }
    
    private func drawDayButtonOfCurrentMonth(button: UIButton, day: Date, objDay: Day?) {
        button.setTitle(String(Calendar.current.component(.day, from: day)), for: UIControl.State.normal)
        
        var dayRate: Int = 0
        if let objDay = objDay {
            dayRate = Int(objDay.dayRate)
        }
        
        if day == Date().getStartDay() {
            drawDayButton(button,
                          drawingType: "today",
                          dayRate: dayRate)
        } else {
            drawDayButton(button,
                          drawingType: "usual",
                          dayRate: dayRate)
        }
    }
    
    private func getStringOfNumberOfDay(from day: Date) -> String {
        return String(Calendar.current.component(.day, from: day))
    }
    
    private func drawInactiveDayButton(button: UIButton, day: Date) {
        button.setTitle(getStringOfNumberOfDay(from: day), for: UIControl.State.normal)
        drawDayButton(button, drawingType: "inactive")
    }
    
    private func drawDayButton(_ button: UIButton, drawingType: String, dayRate: Int = 0) {
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.darkText.cgColor
        
        switch drawingType {
        case "usual":
            button.isEnabled = true
            button.layer.borderWidth = 1
            button.tintColor = UIColor.darkText
        case "today":
            button.isEnabled = true
            button.layer.borderWidth = 4
            button.tintColor = UIColor.darkText
        case "inactive":
            button.isEnabled = false
            button.layer.borderWidth = 0
            button.tintColor = UIColor.lightGray
        default: break
        }
        
        switch dayRate {
        case 1:
            button.backgroundColor = UIColor.red
        case 2:
            button.backgroundColor = UIColor.orange
        case 3:
            button.backgroundColor = UIColor.yellow
        case 4:
            button.backgroundColor = UIColor.blue
        case 5:
            button.backgroundColor = UIColor.green
        default:
            button.backgroundColor = UIColor.white
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as UIViewController
        let button = sender as! UIButton
        destinationVC.title = button.currentTitle!
    }
}


