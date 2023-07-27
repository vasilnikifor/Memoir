import UIKit

extension RateConsoleView {
    struct Configuration {
        let title: String
        let isBackgroundBlurred: Bool
        let rateBadButtonConfiguration: ConsoleButton.Configuration
        let rateNormButtonConfiguration: ConsoleButton.Configuration
        let rateGoodButtonConfiguration: ConsoleButton.Configuration
    }
}

final class RateConsoleView: UIView, Configurable {
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

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primaryMedium)
        label.textAlignment = .center
        return label
    }()

    private lazy var rateBadButton: ConsoleButton = {
        ConsoleButton()
    }()

    private lazy var rateNormButton: ConsoleButton = {
        ConsoleButton()
    }()

    private lazy var rateGoodButton: ConsoleButton = {
        ConsoleButton()
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = .s
        stackView.addArrangedSubview(rateBadButton)
        stackView.addArrangedSubview(rateNormButton)
        stackView.addArrangedSubview(rateGoodButton)
        return stackView
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
        titleLabel.text = configuration.title
        blurView.isVisible = configuration.isBackgroundBlurred
        cardView.isVisible = !configuration.isBackgroundBlurred
        rateBadButton.configure(with: configuration.rateBadButtonConfiguration)
        rateNormButton.configure(with: configuration.rateNormButtonConfiguration)
        rateGoodButton.configure(with: configuration.rateGoodButtonConfiguration)
    }

    private func setup() {
        addSubview(blurView)
        addSubview(cardView)
        addSubview(titleLabel)
        addSubview(buttonsStackView)

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

        titleLabel
            .topToSuperview(.m)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)

        buttonsStackView
            .top(to: titleLabel, anchor: titleLabel.bottomAnchor, offset: .s)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .bottomToSuperview(-.m)
    }
}
