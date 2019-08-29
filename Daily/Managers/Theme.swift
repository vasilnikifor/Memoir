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
            return UIColor.systemGreen
        default:
            return UIColor.clear
        }
    }
    
    static func getRateImage(_ rate: DayRate?, filed: Bool = true) -> UIImage {
        switch rate {
        case .noRate where filed:
            return UIImage(systemName: "smoke.fill")!
            
        case .noRate:
            return UIImage(systemName: "smoke")!
            
        case .bad where filed:
            return UIImage(systemName: "cloud.rain.fill")!
            
        case .bad:
            return UIImage(systemName: "cloud.rain")!
            
        case .norm where filed:
            return UIImage(systemName: "cloud.sun.fill")!
            
        case .norm:
            return UIImage(systemName: "cloud.sun")!
            
        case .good where filed:
            return UIImage(systemName: "sun.max.fill")!
            
        case .good:
            return UIImage(systemName: "sun.max")!
        
        case .none where filed:
            return UIImage(systemName: "smoke.fill")!
            
        case .none:
            return UIImage(systemName: "smoke")!
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
