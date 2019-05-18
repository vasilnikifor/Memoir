import Foundation
import UIKit

class CalendarDrawer {
    static let drawer = CalendarDrawer()
    
    private init(){}
    
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
    
    func getDayRateColor(_ day: Day?) -> UIColor {
        let dayRate = getDayRate(day)
        
        switch dayRate {
        case 0.0:
            return dayEvaluation.eval0
        case 1.0:
            return dayEvaluation.eval1
        case 2.0:
            return dayEvaluation.eval2
        case 3.0:
            return dayEvaluation.eval3
        case 4.0:
            return dayEvaluation.eval4
        case 5.0:
            return dayEvaluation.eval5
        default:
            return dayEvaluation.defaultEval
        }
    }
    
    private struct dayEvaluation {
        static let eval0 = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0) // #f5f5f5 Grey
        static let eval1 = UIColor(red:0.97, green:0.73, blue:0.82, alpha:1.0) // #f8bbd0 Pink
        static let eval2 = UIColor(red:0.97, green:0.73, blue:0.82, alpha:1.0) // #f8bbd0 Pink
        static let eval3 = UIColor(red:0.77, green:0.79, blue:0.91, alpha:1.0) // #c5cae9 Indigo
        static let eval4 = UIColor(red:0.86, green:0.93, blue:0.78, alpha:1.0) // #dcedc8 Light Green
        static let eval5 = UIColor(red:0.86, green:0.93, blue:0.78, alpha:1.0) // #dcedc8 Light Green
        static let defaultEval = UIColor.white
    }
}
