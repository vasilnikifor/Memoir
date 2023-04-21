import UIKit

enum LabelStyle {
    case headerBig
    case headerMedium
    case primaryBig
    case primaryMedium
    case primarySmall
    case secondaryMedium
    case secondarySmall
}

extension UILabel {
    func apply(style: LabelStyle) {
        switch style {
        case .headerBig:
            font = UIFont.boldSystemFont(ofSize: 27)
            textColor = Theme.primaryText
        case .headerMedium:
            font = UIFont.boldSystemFont(ofSize: 17)
            textColor = Theme.primaryText
        case .primaryBig:
            font = UIFont.systemFont(ofSize: 24)
            textColor = Theme.primaryText
        case .primaryMedium:
            font = UIFont.systemFont(ofSize: 17)
            textColor = Theme.primaryText
        case .primarySmall:
            font = UIFont.systemFont(ofSize: 12)
            textColor = Theme.primaryText
        case .secondaryMedium:
            font = UIFont.systemFont(ofSize: 17)
            textColor = Theme.secondaryText
        case .secondarySmall:
            font = UIFont.systemFont(ofSize: 12)
            textColor = Theme.secondaryText
        }
    }
}
