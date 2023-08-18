import UIKit

extension ActionSheet {
    struct ActionSheetItem {
        let title: String
        let icon: UIImage?
        let style: ActionSheetStyle
        let action: (() -> Void)?

        init(
            title: String,
            icon: UIImage? = nil,
            style: ActionSheetStyle,
            action: (() -> Void)?
        ) {
            self.title = title
            self.icon = icon
            self.style = style
            self.action = action
        }
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

struct ActionSheet {
    let title: String?
    let sheetActions: [ActionSheetItem]

    init(
        title: String? = nil,
        sheetActions: [ActionSheetItem]
    ) {
        self.title = title
        self.sheetActions = sheetActions
    }
}
