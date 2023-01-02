import Foundation

protocol CmsRateProtocol {
    var rate: String { get }
    var bad: String { get }
    var good: String { get }
    var great: String { get }
}

final class CmsRate: CmsRateProtocol {
    var rate: String {
        switch Locale.currentLocale {
        case .en:
            return "Rate"
        }
    }

    var bad: String {
        switch Locale.currentLocale {
        case .en:
            return "Bad"
        }
    }

    var good: String {
        switch Locale.currentLocale {
        case .en:
            return "Good"
        }
    }

    var great: String {
        switch Locale.currentLocale {
        case .en:
            return "Great"
        }
    }
}
