import UIKit

final class Theme {
    static var primaryTextColor: UIColor {
        return .label
    }

    static var secondoryTextColor: UIColor {
        return .placeholderText
    }
    
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
            return UIImage(systemName: "smoke.fill") ?? UIImage()
            
        case .noRate:
            return UIImage(systemName: "smoke") ?? UIImage()
            
        case .bad where filed:
            return UIImage(systemName: "cloud.rain.fill") ?? UIImage()
            
        case .bad:
            return UIImage(systemName: "cloud.rain") ?? UIImage()
            
        case .norm where filed:
            return UIImage(systemName: "cloud.sun.fill") ?? UIImage()
            
        case .norm:
            return UIImage(systemName: "cloud.sun") ?? UIImage()
            
        case .good where filed:
            return UIImage(systemName: "sun.max.fill") ?? UIImage()
            
        case .good:
            return UIImage(systemName: "sun.max") ?? UIImage()
        
        case .none where filed:
            return UIImage(systemName: "smoke.fill") ?? UIImage()
            
        case .none:
            return UIImage(systemName: "smoke") ?? UIImage()
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
