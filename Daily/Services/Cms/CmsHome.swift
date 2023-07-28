import Foundation

protocol CmsHomeProtocol {
    var selectDateRange: String { get }
    var howWasYesterday: String { get }
    var howIsToday: String { get }
    func wholeYear(year: String) -> String
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

    var howIsToday: String {
        switch Locale.currentLocale {
        case .en:
            return "How are you today?"
        }
    }

    func wholeYear(year: String) -> String {
        switch Locale.currentLocale {
        case .en:
            return "Whole \(year)"
        }
    }
}
