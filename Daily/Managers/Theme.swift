import UIKit

class Theme {
    
    // MARK: - Properties
    
    static var textColor: UIColor {
        return UIColor.label
    }

    static var secondoryTextColor: UIColor {
        return UIColor.placeholderText
    }
    
    // MARK: - Methods
    
    static func getRateColor(_ rate: DayRate?) -> UIColor {
        switch rate {
        case .noRate:
            return UIColor.systemGray
        case .bad:
            return UIColor.systemRed
        case .norm:
            return UIColor.systemBlue
        case .good:
            return UIColor.systemYellow
        default:
            return UIColor.clear
        }
    }
    
    static func getRateImage(_ rate: DayRate) -> UIImage {
        switch rate {
        case .noRate:
            return UIImage(systemName: "smoke.fill")!
        case .bad:
            return UIImage(systemName: "cloud.rain.fill")!
        case .norm:
            return UIImage(systemName: "cloud.sun.fill")!
        case .good:
            return UIImage(systemName: "sun.max.fill")!
        }
    }
    
    static func getRateName(_ rate: DayRate) -> String {
        switch rate {
        case .noRate:
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
