import Foundation

protocol CmsCommonProtocol {
    var cancel: String { get }
    var search: String { get }
    var share: String { get }
    var note: String { get }
}

final class CmsCommon: CmsCommonProtocol {
    var cancel: String {
        switch Locale.currentLocale {
        case .en:
            return "Cancel"
        }
    }

    var search: String {
        switch Locale.currentLocale {
        case .en:
            return "Search"
        }
    }

    var share: String {
        switch Locale.currentLocale {
        case .en:
            return "Share"
        }
    }

    var note: String {
        switch Locale.currentLocale {
        case .en:
            return "Note"
        }
    }
}
