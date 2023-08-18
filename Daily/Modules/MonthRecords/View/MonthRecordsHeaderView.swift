import UIKit

struct MonthRecordsHeaderViewModel {
    let title: String
    let isRateIconVisible: Bool
    let rateIconImage: UIImage?
    let rateIconTint: UIColor?
    let action: (() -> Void)?
}

final class MonthRecordsHeaderView: UIView {
    private var action: (() -> Void)?

    private var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .m
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = .dLayeredForeground
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primaryBig)
        label.numberOfLines = .zero
        return label
    }()

    private let rateImageView: UIImageView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .dLayeredBackground
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
    private func viewTouchUpInside() {
        action?()
    }
}

extension MonthRecordsHeaderView: Configurable {
    func configure(with viewModel: MonthRecordsHeaderViewModel) {
        titleLabel.text = viewModel.title
        rateImageView.image = viewModel.rateIconImage
        rateImageView.tintColor = viewModel.rateIconTint
        rateImageView.isVisible = viewModel.isRateIconVisible
        action = viewModel.action
    }
}
