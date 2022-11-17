import Foundation

protocol CmsCalendarProtocol {
    var today: String { get }
}

final class CmsCalendar: CmsCalendarProtocol {
    var today: String {
        switch Locale.currentLocale {
        case .en:
            return "Today"
        }
    }
}
