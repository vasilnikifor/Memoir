import UIKit

enum LabelStyle {
    case largePrimary
    case mediumPrimaryText
}

extension UILabel {
    func apply(style: LabelStyle) {
        switch style {
        case .largePrimary:
            font = UIFont.systemFont(ofSize: 24)
            textColor = Theme.primaryTextColor
        case .mediumPrimaryText:
            font = UIFont.systemFont(ofSize: 17)
            textColor = Theme.primaryTextColor
        }
    }
}
