import Foundation

enum MaintainedLocale {
    case en
    
    var locale: Locale {
        switch self {
        case .en: return Locale(identifier: "en")
        }
    }
}
