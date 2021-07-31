import UIKit

struct DayHeaderViewModel {
    let title: String
    let image: UIImage?
    let imageTintColor: UIColor?
    let action: (() -> ())?
}

final class DayHeaderView: UIView {
    private var action: (() -> ())?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primary24)
        label.numberOfLines = .zero
        return label
    }()
    
    private let rateImageView: UIImageView = {
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
    
    private func setup() {
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(rateImageView)
        
        titleLabel
            .topToSuperview(relation: .greaterThanOrEqual)
            .bottomToSuperview(-16)
            //.centerYToSuperview()
            .leadingToSuperview(16)
            .trailing(to: rateImageView, anchor: rateImageView.leadingAnchor, offset: -4)
        
        
        rateImageView
            .height(40)
            .width(40)
            .trailingToSuperview(-16)
            .topToSuperview(32)
            .bottomToSuperview(-16)
        
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

extension DayHeaderView: ViewModelSettable {
    func setup(with viewModel: DayHeaderViewModel) {
        titleLabel.text = viewModel.title
        rateImageView.image = viewModel.image
        action = viewModel.action
        if let imageTintColor = viewModel.imageTintColor {
            rateImageView.tintColor = imageTintColor
        }
    }
}
