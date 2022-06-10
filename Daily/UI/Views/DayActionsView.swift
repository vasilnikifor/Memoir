import UIKit

struct DayActionsViewModel {
    let rate: DayRate?
    let rateAction: (() -> ())?
    let addNoteAction: (() -> ())?
}

final class DayActionsView: UIView {
    var rateAction: (() -> ())?
    var addNoteAction: (() -> ())?
    
    
    var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = Theme.topLayerBackgroundColor
        return view
    }()
    
    lazy var rateDayButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.rateDayImage, for: .normal)
        button.addTarget(self, action: #selector(rateDateButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.addNoteImage, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(rateDayButton)
        stackView.addArrangedSubview(addNoteButton)
        return stackView
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
        cardView.addSubview(actionsStackView)
        
        cardView
            .topToSuperview()
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            .bottomToSuperview(-8)
        
        actionsStackView
            .leadingToSuperview()
            .trailingToSuperview()
            .topToSuperview()
            .bottomToSuperview()
            .height(48)
    }
    
    @objc
    func rateDateButtonTouchUpInside() {
        rateAction?()
    }
    
    @objc
    func addNoteButtonTouchUpInside() {
        addNoteAction?()
    }
}

extension DayActionsView: ViewModelSettable {
    func setup(with viewModel: DayActionsViewModel) {
        rateDayButton.setImage(viewModel.rate.image, for: .normal)
        rateAction = viewModel.rateAction
        addNoteAction = viewModel.addNoteAction
    }
}
