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
        
        switch dayType {
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
    }
    
    private func getDayRate(_ day: Day?) -> Int {
        if let day = day {
            return Int(day.dayRate)
        } else {
            return 0
        }
    }
    
    private func getStringOfNumberOfDay(from day: Date) -> String {
        return String(Calendar.current.component(.day, from: day))
    }
    
    func getDayRateColor(_ day: Day?) -> UIColor {
        let dayRate = getDayRate(day)
        
        switch dayRate {
        case 1:
            return dayEvaluation.eval1
        case 2:
            return dayEvaluation.eval2
        case 3:
            return dayEvaluation.eval3
        case 4:
            return dayEvaluation.eval4
        case 5:
            return dayEvaluation.eval5
        default:
            return dayEvaluation.eval0
        }
    }
    
    private struct dayEvaluation {
        static let eval0 = UIColor.white
        static let eval1 = UIColor.red
        static let eval2 = UIColor.orange
        static let eval3 = UIColor.yellow
        static let eval4 = UIColor.green
        static let eval5 = UIColor.red
    }
}
