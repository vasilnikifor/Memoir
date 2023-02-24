import UIKit

extension EmptyStateView {
    struct Model {
        let illustrationImage: UIImage?
        let title: String?
        let subtitle: String
        let buttonIcon: UIImage?
        let buttonTitle: String
        let buttonAction: (() -> Void)?
    }
}

final class EmptyStateView: UIView {
    private lazy var illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primaryBig)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .secondaryMedium)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()

    private let mainButton: UIButton = {
        let button = UIButton()
        button.apply(style: .primary)
        return button
    }()

    private let illustrationDescriptionView: UIView = {
        UIView()
    }()

    private let illustrationDescriptionCenteringView: UIView = {
        UIView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        addSubview(illustrationDescriptionCenteringView)
        addSubview(mainButton)

        illustrationDescriptionCenteringView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottom(to: mainButton, anchor: mainButton.topAnchor)

        mainButton
            .bottomToSuperview(-.m)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .height(.buttonHeight)

        illustrationDescriptionCenteringView.addSubview(illustrationDescriptionView)

        illustrationDescriptionView
            .leadingToSuperview()
            .trailingToSuperview()
            .centerYToSuperview()

        illustrationDescriptionView.addSubview(illustrationImageView)
        illustrationDescriptionView.addSubview(titleLabel)
        illustrationDescriptionView.addSubview(subtitleLabel)

        illustrationImageView
            .topToSuperview()
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .height(.illustrationHeight)

        titleLabel
            .top(to: illustrationImageView, anchor: illustrationImageView.bottomAnchor, offset: .m)
            .leadingToSuperview(.xl)
            .trailingToSuperview(-.xl)

        subtitleLabel
            .top(to: titleLabel, anchor: titleLabel.bottomAnchor, offset: .s)
            .leadingToSuperview(.xl)
            .trailingToSuperview(-.xl)
            .bottomToSuperview()
    }
}

extension EmptyStateView: ViewModelSettable {
    func setup(with model: Model) {
        illustrationImageView.image = model.illustrationImage
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        mainButton.addAction(UIAction { _ in model.buttonAction?() }, for: .touchUpInside)
        mainButton.setTitle(model.buttonTitle, for: .normal)
        mainButton.imageView?.contentMode = .scaleAspectFit
    }
}
