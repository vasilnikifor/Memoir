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
        label.apply(style: .headerBig)
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .secondaryMedium)
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()

    private let mainButton: UIButton = {
        let button = UIButton()
        button.apply(style: .accent)
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

    private func setup() {
        addSubview(illustrationImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(mainButton)

        titleLabel
            .topToSuperview(.l)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)

        subtitleLabel
            .top(to: titleLabel, anchor: titleLabel.bottomAnchor, offset: .m)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
        
        illustrationImageView
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .height(.illustrationHeight)
            .centerYToSuperview()

        mainButton
            .bottomToSuperview(-.m)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .height(.buttonHeight)
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
