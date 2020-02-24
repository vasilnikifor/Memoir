import UIKit

class CcalendarViewController: UIViewController {
 
    // MARK: - Private propertis
    
    private var month = Date().firstDayOfMonth
    private var dayButtonMatch: [UIButton: Date] = [:]
    private let calendarDrawer = CalendarDrawer()
    
    // MARK: - Outlets
    
    @IBOutlet private var monthLabel: LargePrimaryLabel!
    @IBOutlet private var weekDayLabel: [UILabel]!
    @IBOutlet private var dayButtons: [UIButton]!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    // MARK: - Navigations
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openerDayView" {
            if let dayViewControllet = segue.destination as? DayViewController {
                dayViewControllet.dayDate = sender as? Date ?? Date()
            }
        }
    }
    
    // MARK: - Private methods
    
    private func drawCalendar() {
        drawWeekDays()
        fillMonthLabel(month: month)
        drawCalendarDayButtons()
    }

    private func drawCalendarDayButtons() {
        dayButtonMatch = [:]
        
        let daysOfMonth     = DAODayService.getAllDaysOfMounth(month)
        let firstDayOfMonth = month.firstDayOfMonth
        let lastDayOfMonth  = month.lastDayOfMonth
        var drawingDay      = getFirstDrowingDay(firstDayOfMonth: firstDayOfMonth)
        
        var hideTheLastButtons = false
        
        for index in 0...dayButtons.count - 1 {
            let button = getButton(by: String(index))!
            
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
                dayType = (drawingDay == Date().startOfDay) ? .today : .usual
            }
            calendarDrawer.drawDayButton(button, dayDate: drawingDay, dayType: dayType, day: day)
            
            drawingDay = drawingDay.addDays(1)
        }
    }
    
    private func getFirstDrowingDay(firstDayOfMonth: Date) -> Date {
        return firstDayOfMonth.addDays(-(Calendar.current.component(.weekday, from: firstDayOfMonth)-1)).startOfDay
    }
    
    private func getDay(daysOfMonth: [Day], date: Date) -> Day? {
        for index in daysOfMonth.indices {
            if daysOfMonth[index].date == date.startOfDay {
                return daysOfMonth[index]
            }
        }
        return nil
    }
    
    private func getButton(by id: String) -> UIButton? {
        for index in dayButtons.indices {
            if dayButtons[index].restorationIdentifier == id {
                return dayButtons[index]
            }
        }
        return nil
    }
    
    private func fillMonthLabel(month: Date) {
        monthLabel.text = month.monthRepresentation
    }
    
    private func drawWeekDays() {
        for index in weekDayLabel.indices {
            let label = weekDayLabel[index]
            label.text = Calendar.current.shortWeekdaySymbols[index]
        }
    }
}



