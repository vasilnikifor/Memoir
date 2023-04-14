import UIKit

struct DayHeaderViewModel {
    let title: String
    let rate: DayRate?
    let action: (() -> Void)?
}

final class DayHeaderView: UIView {
    var action: (() -> Void)?

    var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .m
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = Theme.layeredForeground
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primaryBig)
        label.numberOfLines = .zero
        return label
    }()

    let rateImageView: UIImageView = {
        return UIImageView()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        backgroundColor = Theme.layeredBackground
        addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(rateImageView)

        cardView
            .topToSuperview(.s)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .bottomToSuperview()

        titleLabel
            .topToSuperview(.m)
            .bottomToSuperview(-.m)
            .leadingToSuperview(.m)
            .trailing(to: rateImageView, anchor: rateImageView.leadingAnchor, offset: -.xs)

        rateImageView
            .height(.xl)
            .width(.xl)
            .centerYToSuperview()
            .trailingToSuperview(-.m)

        addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(viewTouchUpInside)
            )
        )
    }

    @objc
    func viewTouchUpInside() {
        action?()
    }
}

extension DayHeaderView: ViewModelSettable {
    func setup(with viewModel: DayHeaderViewModel) {
        titleLabel.text = viewModel.title
        rateImageView.image = viewModel.rate.filledImage
        rateImageView.tintColor = viewModel.rate.tintColor
        rateImageView.isHidden = viewModel.rate == nil
        action = viewModel.action
    }
}
