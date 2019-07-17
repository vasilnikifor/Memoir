import Foundation
import UIKit

class CalendarDrawer {
    
    func drawDayButton(button: UIButton, dayDate: Date, dayType: String, day: Day?) {
        button.setTitle(getStringOfNumberOfDay(from: dayDate), for: UIControl.State.normal)
        
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.darkText.cgColor
        button.backgroundColor = getDayRateColor(day)
        
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 0.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        
        switch dayType {
        case "usual":
            button.isEnabled = true
            button.layer.borderWidth = 1
            button.tintColor = UIColor.darkText
            
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 2.0
        case "today":
            button.isEnabled = true
            button.layer.borderWidth = 2
            button.tintColor = UIColor.darkText
            
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 8.0
        case "inactive":
            button.isEnabled = false
            button.layer.borderWidth = 0
            button.tintColor = UIColor.lightGray
        default: break
        }
    }
    
    func getDayRateColor(_ day: Day?) -> UIColor {
        return CalendarDrawer.getRateColor(getDayRate(day))
    }
    
    func getDayRateImage(_ day: Day?) -> UIImage {
        return CalendarDrawer.getDayRateImage(getDayRate(day))
    }
    
    // MARK: -
    
    static func getDayRateImage(_ rate: Double?) -> UIImage {
        switch rate {
        case 0.0:
            return UIImage(named: "goodMood")!
        case 1.0:
            return UIImage(named: "badMood")!
        case 2.0:
            return UIImage(named: "averageMood")!
        case 3.0:
            return UIImage(named: "goodMood")!
        default:
            return UIImage(named: "goodMood")!
        }
    }
    
    static func getRateColor(_ rate: Double?) -> UIColor {
        switch rate {
        case 0.0:
            return dayEvaluation.eval0
        case 1.0:
            return dayEvaluation.eval1
        case 2.0:
            return dayEvaluation.eval2
        case 3.0:
            return dayEvaluation.eval3
        default:
            return dayEvaluation.defaultEval
        }
    }
    
    // MARK: -
    
    private func getDayRate(_ day: Day?) -> Double? {
        if let day = day {
            return day.dayRate
        } else {
            return nil
        }
    }
    
    private func getStringOfNumberOfDay(from day: Date) -> String {
        return String(Calendar.current.component(.day, from: day))
    }
    
    private struct dayEvaluation {
        static let eval0 = UIColor(red: 0.158, green: 0.158, blue: 0.158, alpha: 0.3) // #9E9E9E Grey
        static let eval1 = UIColor(red: 0.233, green: 0.30,  blue: 0.99,  alpha: 0.5) // #E91E63 Pink
        static let eval2 = UIColor(red: 0.63,  green: 0.81,  blue: 0.181, alpha: 0.5) // #3F51B5 Indigo
        static let eval3 = UIColor(red: 0.139, green: 0.195, blue: 0.74,  alpha: 0.5) // #8BC34A Light Green
        static let defaultEval = UIColor.white
    }
    
}
