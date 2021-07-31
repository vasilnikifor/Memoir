import UIKit

struct DayRateViewModel {
    let image: UIImage
    let tintColor: UIColor
    let isSelected: Bool
    let action: (() -> ())?
}

final class DayRateView: UIView {
    private var aciton: (() -> ())?
    
    private lazy var rateView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(viewTapped)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let selectionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = Theme.primaryTextColor
        return view
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
        addSubview(rateView)
        addSubview(selectionView)
        
        rateView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
            
        selectionView
            .centerXToSuperview()
            .bottom(to: rateView, anchor: rateView.bottomAnchor, offset: 8)
            .height(4)
            .width(4)
    }
    
    @objc
    private func viewTapped() {
        aciton?()
    }
}

extension DayRateView: ViewModelSettable {
    func setup(with viewModel: DayRateViewModel) {
        rateView.image = viewModel.image
        rateView.tintColor = viewModel.tintColor
        selectionView.backgroundColor = viewModel.tintColor
        selectionView.isHidden = !viewModel.isSelected
        aciton = viewModel.action
    }
}
