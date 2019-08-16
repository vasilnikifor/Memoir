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
            if #available(iOS 13, *) {
                return UIColor.systemBackground
            } else {
                return UIColor.white
            }
        }
    }
    
    static func getRateColor(_ rate: DayRate) -> UIColor {
        switch rate {
        case .none:
            return UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        case .bad:
            return UIColor(red: 1, green: 64/255, blue: 97/255, alpha: 1)
        case .norm:
            return UIColor(red: 1, green: 150/255, blue: 0, alpha: 1)
        case .good:
            return UIColor(red: 49/255, green: 180/255, blue: 72/255, alpha: 1)
        }
    }
    
    static func getRateImage(_ rate: DayRate) -> UIImage {
        if #available(iOS 13, *) {
            switch rate {
            case .none:
                return UIImage(systemName: "sun.max.fill")!
            case .bad:
                return UIImage(systemName: "cloud.rain.fill")!
            case .norm:
                return UIImage(systemName: "cloud.sun.fill")!
            case .good:
                return UIImage(systemName: "sun.max.fill")!
            }
        } else {
            switch rate {
            case .none:
                return UIImage(named: "averageMood")!
            case .bad:
                return UIImage(named: "badMood")!
            case .norm:
                return UIImage(named: "averageMood")!
            case .good:
                return UIImage(named: "goodMood")!
            }
        }
    }
    
    static func getRateName(_ rate: DayRate) -> String {
        switch rate {
        case .none:
            return "No rate"
        case .bad:
            return "Bad day"
        case .norm:
            return "Average day"
        case .good:
            return "Good day"
        }
    
    }
    
}


