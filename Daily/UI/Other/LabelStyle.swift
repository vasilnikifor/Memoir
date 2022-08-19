import UIKit

enum LabelStyle {
    case headerMedium
    case primaryBig
    case primaryMedium
    case primarySmall
    case secondarySmall
}

extension UILabel {
    func apply(style: LabelStyle) {
        switch style {
        case .headerMedium:
            font = UIFont.boldSystemFont(ofSize: 17)
            textColor = Theme.primaryTextColor
        case .primaryBig:
            font = UIFont.systemFont(ofSize: 24)
            textColor = Theme.primaryTextColor
        case .primaryMedium:
            font = UIFont.systemFont(ofSize: 17)
            textColor = Theme.primaryTextColor
        case .primarySmall:
            font = UIFont.systemFont(ofSize: 12)
            textColor = Theme.primaryTextColor
        case .secondarySmall:
            font = UIFont.systemFont(ofSize: 12)
            textColor = Theme.secondaryTextColor
        }
    }
}
