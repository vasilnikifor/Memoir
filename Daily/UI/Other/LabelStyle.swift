import UIKit

enum LabelStyle {
    case primary17
    case primary24
    case secondory9
}

extension UILabel {
    func apply(style: LabelStyle) {
        switch style {
        case .primary17:
            font = UIFont.systemFont(ofSize: 17)
            textColor = Theme.primaryTextColor
        case .primary24:
            font = UIFont.systemFont(ofSize: 24)
            textColor = Theme.primaryTextColor
        case .secondory9:
            font = UIFont.systemFont(ofSize: 9)
            textColor = Theme.secondoryTextColor
        }
    }
}
