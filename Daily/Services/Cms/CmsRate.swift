import Foundation

protocol CmsRateProtocol {
    var rate: String { get }
    var bad: String { get }
    var norm: String { get }
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

    var norm: String {
        switch Locale.currentLocale {
        case .en:
            return "Norm"
        }
    }

    var good: String {
        switch Locale.currentLocale {
        case .en:
            return "Good"
        }
    }
}
