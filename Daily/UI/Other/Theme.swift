import UIKit

final class Theme {
    static var primaryTextColor: UIColor {
        return .label
    }

    static var secondoryTextColor: UIColor {
        return .placeholderText
    }
    
    static var backgroundColor: UIColor {
        return .systemBackground
    }
    
    static func getRateColor(_ rate: DayRate?) -> UIColor {
        switch rate {
        case .none:
            return UIColor { (trait) -> UIColor in
                trait.userInterfaceStyle == .dark
                    ? UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00) // #424242
                    : UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00) // #eeeeee
            }
        case .bad:
            return UIColor { (trait) -> UIColor in
                trait.userInterfaceStyle == .dark
                    ? UIColor(red: 0.78, green: 0.16, blue: 0.16, alpha: 1.00) // #c62828
                    : UIColor(red: 0.94, green: 0.60, blue: 0.60, alpha: 1.00) // #ef9a9a
            }
        case .average:
            return UIColor { (trait) -> UIColor in
                trait.userInterfaceStyle == .dark
                    ? UIColor(red: 0.08, green: 0.40, blue: 0.75, alpha: 1.00) // #1565c0
                    : UIColor(red: 0.56, green: 0.79, blue: 0.98, alpha: 1.00) // #90caf9
            }
        case .good:
            return UIColor { (trait) -> UIColor in
                trait.userInterfaceStyle == .dark
                    ? UIColor(red: 0.18, green: 0.49, blue: 0.20, alpha: 1.00) // #2e7d32
                    : UIColor(red: 0.65, green: 0.84, blue: 0.65, alpha: 1.00) // #a5d6a7
            }
        default:
            return UIColor.clear
        }
    }
    
    static func getRateImage(_ rate: DayRate?, filed: Bool = true) -> UIImage {
        switch rate {
        case .none where filed:
            return UIImage(systemName: "smoke.fill") ?? UIImage()
            
        case .none:
            return UIImage(systemName: "smoke") ?? UIImage()
            
        case .bad where filed:
            return UIImage(systemName: "cloud.rain.fill") ?? UIImage()
            
        case .bad:
            return UIImage(systemName: "cloud.rain") ?? UIImage()
            
        case .average where filed:
            return UIImage(systemName: "cloud.sun.fill") ?? UIImage()
            
        case .average:
            return UIImage(systemName: "cloud.sun") ?? UIImage()
            
        case .good where filed:
            return UIImage(systemName: "sun.max.fill") ?? UIImage()
            
        case .good:
            return UIImage(systemName: "sun.max") ?? UIImage()
        
        case .none where filed:
            return UIImage(systemName: "smoke.fill") ?? UIImage()
        }
    }
    
    static func getRateName(_ rate: DayRate) -> String {
        switch rate {
        case .bad:
            return Localized.badDay
        case .average:
            return Localized.averageDay
        case .good:
            return Localized.goodDay
        }
    }
}
