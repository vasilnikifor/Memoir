import UIKit

extension CalendarHatView {
    enum Constants {
        static let upImage: UIImage? = UIImage(systemName: "arrow.right")
        static let downImage: UIImage? = UIImage(systemName: "arrow.left")
        static let forwardImage: UIImage? = UIImage(systemName: "chevron.forward")
    }
}

final class CalendarHatView: UIView {
    var upTapped: (() -> Void)?
    var downTapped: (() -> Void)?
    var forwardTapped: (() -> Void)?

    lazy var downButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.downImage, for: .normal)
        button.addTarget(self, action: #selector(downButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var upButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.upImage, for: .normal)
        button.addTarget(self, action: #selector(upButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var forwardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.forwardImage
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forwardButtonTapped)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primaryBig)
        label.textAlignment = .center
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(forwardButtonTapped)))
        label.isUserInteractionEnabled = true
        return label
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
        addSubview(upButton)
        addSubview(downButton)
        addSubview(forwardImageView)
        addSubview(nameLabel)

        height(.xl)

        downButton
            .topToSuperview()
            .leadingToSuperview()
            .height(.xl)
            .width(.xl)

        upButton
            .topToSuperview()
            .trailingToSuperview()
            .height(.xl)
            .width(.xl)

        nameLabel
            .centerYToSuperview()
            .centerXToSuperview()

        forwardImageView
            .height(.m)
            .width(.m)
            .leading(to: nameLabel, anchor: nameLabel.trailingAnchor, offset: .s)
            .centerYToSuperview()
    }

    @objc
    func upButtonTapped() {
        upTapped?()
    }

    @objc
    func downButtonTapped() {
        downTapped?()
    }

    @objc
    func forwardButtonTapped() {
        forwardTapped?()
    }
}
