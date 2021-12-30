import Foundation
import UIKit

enum DayRate: CaseIterable {
    case bad
    case average
    case good
}

extension Optional where Wrapped == DayRate {
    var image: UIImage? {
        switch self {
        case .none:
            return Theme.rateDayImage
        case .bad:
            return Theme.badRateImage
        case .average:
            return Theme.averageRateImage
        case .good:
            return Theme.goodRateImage
        }
    }
    
    var tintColor: UIColor? {
        switch self {
        case .none:
            return nil
        case .bad:
            return Theme.badRateColor
        case .average:
            return Theme.averageRateColor
        case .good:
            return Theme.goodRateColor
        }
    }
}
