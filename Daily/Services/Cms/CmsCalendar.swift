import Foundation

protocol CmsCalendarProtocol {
    var today: String { get }
    var previousMonth: String { get }
    var nextMonth: String { get }
}

final class CmsCalendar: CmsCalendarProtocol {
    var today: String {
        switch Locale.currentLocale {
        case .en:
            return "Today"
        }
    }

    var previousMonth: String {
        switch Locale.currentLocale {
        case .en:
            return "Previous month"
        }
    }

    var nextMonth: String {
        switch Locale.currentLocale {
        case .en:
            return "Next month"
        }
    }
}
