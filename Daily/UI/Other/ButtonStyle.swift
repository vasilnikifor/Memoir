import UIKit


extension UIButton {
    enum Style {
        case consoleButton
        case filled
    }
}

extension UIButton {
    convenience init(style: Style, action: (() -> Void)? = nil) {
        switch style {
        case .consoleButton:
            var configuration = UIButton.Configuration.borderless()
            configuration.imagePlacement = .top
            configuration.imagePadding = .m
            configuration.buttonSize = .mini
            self.init(configuration: configuration)
        case .filled:
            self.init(configuration: UIButton.Configuration.filled())
        }

        if let action {
            addAction(UIAction { _ in action() }, for: .touchUpInside)
        }
    }
}

