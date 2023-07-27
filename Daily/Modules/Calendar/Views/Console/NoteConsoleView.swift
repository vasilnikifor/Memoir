import UIKit

extension NoteConsoleView {
    struct Configuration {
        let title: String
        let image: UIImage
        let isBackgroundBlurred: Bool
        let action: (() -> Void)?
    }
}

final class NoteConsoleView: UIView, Configurable {
    private var action: (() -> Void)?

    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        view.isVisible = false
        view.layer.cornerRadius = .m
        view.clipsToBounds = true
        return view
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.layeredForeground
        view.layer.cornerRadius = .m
        view.clipsToBounds = true
        return view
    }()

    private lazy var addNoteButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        let button = UIButton(configuration: configuration)
        button.layer.cornerRadius = .s
        button.addTarget(self, action: #selector(addNotButtonDidTap), for: .touchUpInside)
        return button
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(with configuration: Configuration) {
        blurView.isVisible = configuration.isBackgroundBlurred
        cardView.isVisible = !configuration.isBackgroundBlurred
        addNoteButton.setTitle(configuration.title, for: .normal)
        iconImageView.image = configuration.image
        action = configuration.action
    }

    private func setup() {
        addSubview(blurView)
        addSubview(cardView)
        addSubview(addNoteButton)
        addSubview(iconImageView)

        blurView
            .topToSuperview()
            .bottomToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()

        cardView
            .topToSuperview()
            .bottomToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()

        addNoteButton
            .topToSuperview()
            .bottomToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .height(.buttonHeight)

        iconImageView
            .centerYToSuperview()
            .leadingToSuperview(.m)
            .height(.l)
            .width(.l)
    }

    @objc
    private func addNotButtonDidTap() {
        action?()
    }
}
