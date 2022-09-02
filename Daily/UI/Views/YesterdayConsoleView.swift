import Foundation
import UIKit

extension YesterdayConsoleView {
    struct Model {
        let title: String
        let rateBadActionModel: ConsoleActionView.Model
        let rateNormActionModel: ConsoleActionView.Model
        let rateGoodActionModel: ConsoleActionView.Model
    }
}

final class YesterdayConsoleView: UIView, ViewModelSettable {
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
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

    private let rateBadActionView: ConsoleActionView = {
        ConsoleActionView()
    }()

    private let rateNormActionView: ConsoleActionView = {
        ConsoleActionView()
    }()

    private let rateGoodActionView: ConsoleActionView = {
        ConsoleActionView()
    }()

    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(rateBadActionView)
        stackView.addArrangedSubview(rateNormActionView)
        stackView.addArrangedSubview(rateGoodActionView)
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
        rateBadActionView.setup(with: model.rateBadActionModel)
        rateNormActionView.setup(with: model.rateNormActionModel)
        rateGoodActionView.setup(with: model.rateGoodActionModel)
    }

    private func setup() {
        addSubview(blurView)
        addSubview(titleLabel)
        addSubview(actionsStackView)

        blurView
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
