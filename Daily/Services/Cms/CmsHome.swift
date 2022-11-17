import Foundation

protocol CmsHomeProtocol {
    var selectDateRange: String { get }
    var howWasYesterday: String { get }
}

final class CmsHome: CmsHomeProtocol {
    var selectDateRange: String {
        switch Locale.currentLocale {
        case .en:
            return "Select date range"
        }
    }

    var howWasYesterday: String {
        switch Locale.currentLocale {
        case .en:
            return "How was yesterday?"
        }
    }
}
