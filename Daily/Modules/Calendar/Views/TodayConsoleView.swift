import UIKit

extension TodayConsoleView {
    struct Model {
        let title: String
        let isBackgroundBlurred: Bool
        let rateBadActionModel: ConsoleActionView.Model?
        let rateNormActionModel: ConsoleActionView.Model?
        let rateGoodActionModel: ConsoleActionView.Model?
        let addNoteActionModel: ConsoleActionView.Model
    }

    enum Appearance {
        static let animationDuration: CGFloat = 0.2
    }
}

final class TodayConsoleView: UIView, ViewModelSettable {
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

    private let rateBadActionView: ConsoleActionView = {
        ConsoleActionView()
    }()

    private let rateNormActionView: ConsoleActionView = {
        ConsoleActionView()
    }()

    private let rateGoodActionView: ConsoleActionView = {
        ConsoleActionView()
    }()

    private let addNoteActionView: ConsoleActionView = {
        return ConsoleActionView()
    }()

    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(rateBadActionView)
        stackView.addArrangedSubview(rateNormActionView)
        stackView.addArrangedSubview(rateGoodActionView)
        stackView.addArrangedSubview(addNoteActionView)
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

    func setup(with model: Model) {
        titleLabel.text = model.title
        blurView.isVisible = model.isBackgroundBlurred
        cardView.isVisible = !model.isBackgroundBlurred

        if let rateBadActionModel = model.rateBadActionModel {
            rateBadActionView.setup(with: rateBadActionModel)
        }

        if let rateNormActionModel = model.rateNormActionModel {
            rateNormActionView.setup(with: rateNormActionModel)
        }

        if let rateGoodActionModel = model.rateGoodActionModel {
            rateGoodActionView.setup(with: rateGoodActionModel)
        }

        addNoteActionView.setup(with: model.addNoteActionModel)

        let isBadDayActionVisible = model.rateBadActionModel != nil
        let isNormDayActionVisible = model.rateNormActionModel != nil
        let isGoodDayActionVisible = model.rateGoodActionModel != nil
        rateBadActionView.isHidden = !isBadDayActionVisible
        rateNormActionView.isHidden = !isNormDayActionVisible
        rateGoodActionView.isHidden = !isGoodDayActionVisible

        UIView.animate(withDuration: Appearance.animationDuration) {
            self.rateBadActionView.alpha = isBadDayActionVisible ? 1 : 0
            self.rateNormActionView.alpha = isNormDayActionVisible ? 1 : 0
            self.rateGoodActionView.alpha = isGoodDayActionVisible ? 1 : 0
            self.layoutIfNeeded()
        }
    }

    private func setup() {
        addSubview(blurView)
        addSubview(cardView)
        addSubview(titleLabel)
        addSubview(actionsStackView)

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

        actionsStackView
            .top(to: titleLabel, anchor: titleLabel.bottomAnchor, offset: .s)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .bottomToSuperview(-.m)
    }
}
