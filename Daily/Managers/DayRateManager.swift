import UIKit

class DayRateManager {
    
    // MARK: - Methods
    
    static func getRaitImage(_ rate: Double?) -> UIImage {
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
            return UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        case 1.0:
            return UIColor(red: 1, green: 64/255, blue: 97/255, alpha: 1)
        case 2.0:
            return UIColor(red: 1, green: 150/255, blue: 0, alpha: 1)
        case 3.0:
            return UIColor(red: 49/255, green: 180/255, blue: 72/255, alpha: 1)
        default:
            return UIColor.white
        }
    }
    
}


