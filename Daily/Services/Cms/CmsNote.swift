import Foundation

protocol CmsNoteProtocol {
    var placeholder: String { get }
    var emptyStateTitle: String { get }
    var emptyStateSubtitle: String { get }
    var addNote: String { get }
}

final class CmsNote: CmsNoteProtocol {
    var emptyStateTitle: String {
        switch Locale.currentLocale {
        case .en:
            return "Each day has its own story"
        }
    }

    var emptyStateSubtitle: String {
        switch Locale.currentLocale {
        case .en:
            return "Add a note and save the day in your memory"
        }
    }

    var addNote: String {
        switch Locale.currentLocale {
        case .en:
            return "Add Note"
        }
    }

    var placeholder: String {
        switch Locale.currentLocale {
        case .en:
            return "Note text..."
        }
    }
}
