import UIKit

extension TodayConsoleView {
    struct Configuration {
        let title: String
        let isBackgroundBlurred: Bool
        let rateBadButtonConfiguration: ConsoleButton.Configuration?
        let rateNormButtonConfiguration: ConsoleButton.Configuration?
        let rateGoodButtonConfiguration: ConsoleButton.Configuration?
        let addNoteButtonConfiguration: ConsoleButton.Configuration
    }

    enum Appearance {
        static let animationDuration: CGFloat = 0.2
    }
}

final class TodayConsoleView: UIView, Configurable {
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        view.layer.cornerRadius = .m
        view.clipsToBounds = true
        return view
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .m
        view.clipsToBounds = true
        view.backgroundColor = Theme.layeredForeground
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

    private lazy var addNoteButton: ConsoleButton = {
        ConsoleButton()
    }()

    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(rateBadButton)
        stackView.addArrangedSubview(rateNormButton)
        stackView.addArrangedSubview(rateGoodButton)
        stackView.addArrangedSubview(addNoteButton)
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

        if let configuration = configuration.rateBadButtonConfiguration {
            rateBadButton.configure(with: configuration)
        }

        if let configuration = configuration.rateNormButtonConfiguration {
            rateNormButton.configure(with: configuration)
        }

        if let configuration = configuration.rateGoodButtonConfiguration {
            rateGoodButton.configure(with: configuration)
        }

        addNoteButton.configure(with: configuration.addNoteButtonConfiguration)

        let isBadDayButtonVisible = configuration.rateBadButtonConfiguration != nil
        let isNormDayButtonVisible = configuration.rateNormButtonConfiguration != nil
        let isGoodDayButtonVisible = configuration.rateGoodButtonConfiguration != nil
        rateBadButton.isHidden = !isBadDayButtonVisible
        rateNormButton.isHidden = !isNormDayButtonVisible
        rateGoodButton.isHidden = !isGoodDayButtonVisible

        UIView.animate(withDuration: Appearance.animationDuration) {
            self.rateBadButton.alpha = isBadDayButtonVisible ? 1 : 0
            self.rateNormButton.alpha = isNormDayButtonVisible ? 1 : 0
            self.rateGoodButton.alpha = isGoodDayButtonVisible ? 1 : 0
            self.layoutIfNeeded()
        }
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
