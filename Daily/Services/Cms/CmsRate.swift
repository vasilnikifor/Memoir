import Foundation

protocol CmsRateProtocol {
    var rate: String { get }
    var bad: String { get }
    var fine: String { get }
    var good: String { get }
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

    var fine: String {
        switch Locale.currentLocale {
        case .en:
            return "Fine"
        }
    }

    var good: String {
        switch Locale.currentLocale {
        case .en:
            return "Good"
        }
    }
}
