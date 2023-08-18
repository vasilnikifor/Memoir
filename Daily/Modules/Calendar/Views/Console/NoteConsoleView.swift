import UIKit

extension NoteConsoleView {
    struct Configuration {
        let title: String
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
        view.backgroundColor = .dLayeredForeground
        view.layer.cornerRadius = .m
        view.clipsToBounds = true
        return view
    }()

    private lazy var addNoteButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePadding = .m
        configuration.cornerStyle = .large
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(addNotButtonDidTap), for: .touchUpInside)
        return button
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
        action = configuration.action
    }

    private func setup() {
        addSubview(blurView)
        addSubview(cardView)
        addSubview(addNoteButton)

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
    }

    @objc
    private func addNotButtonDidTap() {
        action?()
    }
}
