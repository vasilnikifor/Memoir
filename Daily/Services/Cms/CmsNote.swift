import Foundation

protocol CmsNoteProtocol {
    var placeholder: String { get }
}

final class CmsNote: CmsNoteProtocol {
    var placeholder: String {
        switch Locale.currentLocale {
        case .en:
            return "Take a note..."
        }
    }
}
