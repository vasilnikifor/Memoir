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

    var filledImage: UIImage? {
        switch self {
        case .none:
            return Theme.rateDayImage
        case .bad:
            return Theme.badRateFilledImage
        case .average:
            return Theme.averageRateFilledImage
        case .good:
            return Theme.goodRateFilledImage
        }
    }
    
    var tintColor: UIColor? {
        switch self {
        case .none:
            return Theme.primaryTextColor
        case .bad:
            return Theme.badRateColor
        case .average:
            return Theme.averageRateColor
        case .good:
            return Theme.goodRateColor
        }
    }
}
