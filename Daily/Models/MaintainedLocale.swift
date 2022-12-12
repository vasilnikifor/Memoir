import Foundation

enum MaintainedLocale {
    case en
    
    var locale: Locale {
        switch self {
        case .en:
            let currentLocale = Calendar.current.locale
            if let locale = currentLocale, locale.identifier.hasPrefix("en") {
                return locale
            } else {
                return Locale(identifier: "en_GB")
            }
        }
    }
}
