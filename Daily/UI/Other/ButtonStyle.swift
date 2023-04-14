import UIKit

enum ButtonStyle {
    case primary
}

extension UIButton {
    func apply(style: ButtonStyle) {
        switch style {
        case .primary:
            layer.cornerRadius = .m
            backgroundColor = Theme.primaryTint
            setTitleColor(Theme.primaryReversedTint, for: .normal)
        }
    }
}
