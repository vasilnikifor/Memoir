import UIKit

struct DayHeaderViewModel {
    let title: String
    let rate: DayRate?
    let action: (() -> ())?
}

final class DayHeaderView: UIView {
    var action: (() -> ())?
     
    var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = Theme.topLayerBackgroundColor
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
        backgroundColor = Theme.bottomLayerBackgroundColor
        addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(rateImageView)
        
        cardView
            .topToSuperview(8)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            .bottomToSuperview()
        
        titleLabel
            .topToSuperview(16)
            .bottomToSuperview(-16)
            .leadingToSuperview(16)
            .trailing(to: rateImageView, anchor: rateImageView.leadingAnchor, offset: -4)
        
        
        rateImageView
            .height(32)
            .width(32)
            .centerYToSuperview()
            .trailingToSuperview(-16)
        
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
        rateImageView.image = viewModel.rate.image
        rateImageView.tintColor = viewModel.rate.tintColor
        rateImageView.isHidden = viewModel.rate == nil
        action = viewModel.action
    }
}
