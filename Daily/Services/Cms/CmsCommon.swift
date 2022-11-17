import Foundation

protocol CmsCommonProtocol {
    var cancel: String { get }
    var note: String { get }
}

final class CmsCommon: CmsCommonProtocol {
    var cancel: String {
        switch Locale.currentLocale {
        case .en:
            return "Cancel"
        }
    }

    var note: String {
        switch Locale.currentLocale {
        case .en:
            return "Note"
        }
    }
}
