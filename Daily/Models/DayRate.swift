import UIKit

enum DayRate: CaseIterable {
    case bad
    case average
    case good
}

extension DayRate {
    var emoji: String {
        switch self {
        case .bad: return "👎"
        case .average: return "👍"
        case .good: return "⭐️"
        }
    }
}

extension Optional where Wrapped == DayRate {
    var image: UIImage {
        switch self {
        case .none:
            return .rateDay
        case .bad:
            return .badRate
        case .average:
            return .averageRate
        case .good:
            return .goodRate
        }
    }

    var filledImage: UIImage {
        switch self {
        case .none:
            return .rateDay
        case .bad:
            return .badRateFilled
        case .average:
            return .averageRateFilled
        case .good:
            return .goodRateFilled
        }
    }

    var tintColor: UIColor {
        switch self {
        case .none:
            return .dPrimaryText
        case .bad:
            return .dBadRateColor
        case .average:
            return .dAverageRateColor
        case .good:
            return .dGoodRateColor
        }
    }
}
