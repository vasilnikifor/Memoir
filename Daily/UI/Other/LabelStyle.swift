import UIKit

enum LabelStyle {
    case largePrimary
}

extension UILabel {
    func apply(style: LabelStyle) {
        switch style {
        case .largePrimary:
            font = UIFont.systemFont(ofSize: 29)
            textColor = Theme.primaryTextColor
        }
    }
}
