import UIKit

enum LabelStyle {
    case primaryBig
    case primaryMedium
    case secondarySmall
}

extension UILabel {
    func apply(style: LabelStyle) {
        switch style {
        case .primaryBig:
            font = UIFont.systemFont(ofSize: 24)
            textColor = Theme.primaryTextColor
        case .primaryMedium:
            font = UIFont.systemFont(ofSize: 17)
            textColor = Theme.primaryTextColor
        case .secondarySmall:
            font = UIFont.systemFont(ofSize: 12)
            textColor = Theme.secondaryTextColor
        }
    }
}
