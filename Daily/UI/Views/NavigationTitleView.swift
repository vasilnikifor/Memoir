import UIKit

extension NavigationTitleView {
    enum Constants {
        static let downImage: UIImage? = UIImage(systemName: "chevron.down")
    }

    struct ViewModel {
        let title: String?
        let action: (() -> Void)?
    }
}

final class NavigationTitleView: UIView, ViewModelSettable {
    private var action: (() -> Void)?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .headerMedium)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()

    private lazy var downImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.downImage
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
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

    func setup(with model: ViewModel) {
        titleLabel.text = model.title
        action = model.action
    }

    private func setup() {
        addSubview(titleLabel)
        addSubview(downImageView)

        titleLabel
            .topToSuperview()
            .bottomToSuperview()
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)

        downImageView
            .height(.m)
            .width(.m)
            .leading(to: titleLabel, anchor: titleLabel.trailingAnchor, offset: .s)
            .centerYToSuperview()

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }

    @objc
    func viewTapped() {
        action?()
    }
}
