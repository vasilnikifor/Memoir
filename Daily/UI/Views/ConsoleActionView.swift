import UIKit

extension ConsoleActionView {
    struct Model {
        let title: String
        let image: UIImage
        let tintColor: UIColor
        let action: (() -> ())?
    }
}

final class ConsoleActionView: UIView, ViewModelSettable {
    private var action: (() -> ())?
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primarySmall)
        label.textAlignment = .center
        label.numberOfLines = .zero
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
    
    func setup(with model: Model) {
        iconImageView.image = model.image
        iconImageView.tintColor = model.tintColor
        titleLabel.text = model.title
        action = model.action
    }
    
    private func setup() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(viewTapped)))
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        iconImageView
            .topToSuperview()
            .centerXToSuperview()
            .height(.l)
            .width(.l)

        titleLabel
            .top(to: iconImageView, anchor: iconImageView.bottomAnchor, offset: .s)
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
    }
    
    @objc
    private func viewTapped() {
        action?()
    }
}
