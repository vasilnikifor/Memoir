import UIKit

enum LabelStyle {
    case primary24
    case primary17
}

extension UILabel {
    func apply(style: LabelStyle) {
        switch style {
        case .primary24:
            font = UIFont.systemFont(ofSize: 24)
            textColor = Theme.primaryTextColor
        case .primary17:
            font = UIFont.systemFont(ofSize: 17)
            textColor = Theme.primaryTextColor
        }
    }
}
