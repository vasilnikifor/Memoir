import UIKit

class CalendarDrawer {
    
    enum DayType {
        case usual
        case today
        case inactive
    }
    
    // MARK: - Methods
    
    func drawDayButton(_ button: UIButton, dayDate: Date, dayType: DayType, day: Day?) {
        setDefaultSetting(on: button, dayDate: dayDate, day: day)
        switch dayType {
        case .usual:
            button.isEnabled = true
            button.tintColor = Theme.textColor
            button.layer.borderWidth = 1
            
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 2.0
        case .today:
            button.isEnabled = true
            button.tintColor = Theme.textColor
            button.layer.borderWidth = 2
            
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 2.0
            
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        case .inactive:
            button.isEnabled = false
            button.tintColor = Theme.secondoryTextColor
            button.layer.borderWidth = 0
        }
    }

    // MARK: - Private methods
    
    private func setDefaultSetting(on button: UIButton, dayDate: Date, day: Day?) {
        button.setTitle(dayDate.getDateNumber(), for: UIControl.State.normal)
        
        button.layer.cornerRadius = 20
        button.layer.borderColor = Theme.textColor.cgColor
        button.backgroundColor = DayRateManager.getRateColor(day?.dayRate)
        
        button.layer.shadowColor = Theme.shadowColor.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
}
