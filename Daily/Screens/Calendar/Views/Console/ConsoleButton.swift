import UIKit

extension ConsoleButton {
    struct Configuration {
        let title: String
        let image: UIImage
        let tintColor: UIColor
        let action: (() -> Void)?
    }
}

final class ConsoleButton: UIButton {
    private var action: (() -> Void)?

    convenience init() {
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePlacement = .top
        configuration.imagePadding = .m
        configuration.buttonSize = .mini
        self.init(configuration: configuration)
        layer.cornerRadius = .s
    }

    @objc
    private func buttonDidTap() {
        action?()
    }
}

extension ConsoleButton: Configurable {
    func configure(with configuration: Configuration) {
        action = configuration.action
        addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        setImage(configuration.image, for: .normal)
        setTitle(configuration.title, for: .normal)
        tintColor = configuration.tintColor
        setTitleColor(.dPrimaryText, for: .normal)
    }
}
