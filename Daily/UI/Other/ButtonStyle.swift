import UIKit

enum ButtonStyle {
    case accent
}

extension UIButton {
    func apply(style: ButtonStyle) {
        switch style {
        case .accent:
            layer.cornerRadius = .m
            backgroundColor = Theme.primaryTint
            setTitleColor(Theme.primaryReversedTint, for: .normal)
        }
    }
}
