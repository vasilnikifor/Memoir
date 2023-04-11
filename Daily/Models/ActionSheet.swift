import UIKit

struct ActionSheet {
    let title: String?
    let sheetActions: [ActionSheetItem]

    struct ActionSheetItem {
        let title: String
        let style: ActionSheetStyle
        let action: (() -> Void)?
    }

    enum ActionSheetStyle {
        case `default`
        case cancel
        case destructive

        var alertActionStyle: UIAlertAction.Style {
            switch self {
            case .default: return .default
            case .cancel: return .cancel
            case .destructive: return .destructive
            }
        }
    }
}
