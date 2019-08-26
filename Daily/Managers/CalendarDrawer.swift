import UIKit

class CalendarDrawer {
    
    enum DayType {
        case usual
        case today
        case inactive
    }
    
    // MARK: - Methods
    
    func drawDayButton(_ button: UIButton, dayDate: Date, dayType: DayType, day: Day?) {

        button.setTitle(dayDate.getDateNumber(), for: UIControl.State.normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = Theme.getRateColor(day?.rate)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        switch dayType {
        case .usual:
            button.isEnabled = true
            button.tintColor = Theme.textColor
        case .today:
            button.isEnabled = true
            button.tintColor = Theme.textColor
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        case .inactive:
            button.isEnabled = false
            button.tintColor = Theme.secondoryTextColor
        }
    }
    
}
