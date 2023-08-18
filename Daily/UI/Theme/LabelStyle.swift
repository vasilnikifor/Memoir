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
            textColor = .dPrimaryText
        case .headerMedium:
            font = UIFont.boldSystemFont(ofSize: 17)
            textColor = .dPrimaryText
        case .primaryBig:
            font = UIFont.systemFont(ofSize: 24)
            textColor = .dPrimaryText
        case .primaryMedium:
            font = UIFont.systemFont(ofSize: 17)
            textColor = .dPrimaryText
        case .primarySmall:
            font = UIFont.systemFont(ofSize: 12)
            textColor = .dPrimaryText
        case .secondaryMedium:
            font = UIFont.systemFont(ofSize: 17)
            textColor = .dSecondaryText
        case .secondarySmall:
            font = UIFont.systemFont(ofSize: 12)
            textColor = .dSecondaryText
        }
    }
}
