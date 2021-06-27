import UIKit

struct CalendarDayViewModel {
    let date: Date
    let isToday: Bool
    let state: State
    let action: (() -> ())?
    
    enum State {
        case unactive
        case empty
        case filled(dayRate: DayRate?)
    }
}

final class CalendarDayViewCell: UICollectionViewCell {
    private var acton: (() -> ())?
    private var buttonHeigtConstraint: NSLayoutConstraint?
    private var buttonWidthConstraint: NSLayoutConstraint?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private let isTodayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let squereEdgeSize = min(frame.height, frame.width)
        let buttonEdgeSize = squereEdgeSize - squereEdgeSize / 4
        button.layer.cornerRadius = buttonEdgeSize / 2
        buttonHeigtConstraint?.constant = buttonEdgeSize
        buttonWidthConstraint?.constant = buttonEdgeSize
    }

    private func commonInit() {
        contentView.addSubview(button)
        contentView.addSubview(isTodayView)
        
        button
            .centerXToSuperview()
            .centerYToSuperview()
        
        buttonHeigtConstraint = button.height(height: .zero)
        buttonWidthConstraint = button.width(width: .zero)
        
        isTodayView
            .height(4)
            .width(4)
            .centerX(to: button)
            .bottom(to: button, anchor: button.bottomAnchor, offset: -4)
    }
    
    @objc
    private func buttonTouchUpInside() {
        acton?()
    }
}

extension CalendarDayViewCell: ViewModelSettable {
    func setup(with viewModel: CalendarDayViewModel) {
        acton = viewModel.action
        isTodayView.isHidden = !viewModel.isToday
        button.setTitle(viewModel.date.dateNumber, for: .normal)
        switch viewModel.state {
        case .unactive:
            isTodayView.backgroundColor = Theme.secondoryTextColor
            button.backgroundColor = .clear
            button.setTitleColor(Theme.secondoryTextColor, for: .normal)
            button.isEnabled = false
        case .empty:
            isTodayView.backgroundColor = Theme.primaryTextColor
            button.backgroundColor = .clear
            button.setTitleColor(Theme.primaryTextColor, for: .normal)
            button.isEnabled = true
        case .filled(let dayRate):
            isTodayView.backgroundColor = Theme.primaryTextColor
            button.setTitleColor(Theme.primaryTextColor, for: .normal)
            button.isEnabled = true
            switch dayRate {
            case .bad:
                button.backgroundColor = Theme.badRateColor
            case .average:
                button.backgroundColor = Theme.averageRateColor
            case .good:
                button.backgroundColor = Theme.goodRateColor
            case .none:
                button.backgroundColor = Theme.noRateColor
            }
        }
    }
}
