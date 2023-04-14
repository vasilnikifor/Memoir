import UIKit

struct CalendarDayViewModel {
    let date: Date
    let isToday: Bool
    let state: State
    let action: (() -> Void)?

    enum State {
        case inactive
        case empty
        case filled(dayRate: DayRate?)
    }
}

final class CalendarDayViewCell: UICollectionViewCell {
    private var acton: (() -> Void)?
    private var buttonHeightConstraint: NSLayoutConstraint?
    private var buttonWidthConstraint: NSLayoutConstraint?

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
        return button
    }()

    private let isTodayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .xxs
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

    override func layoutSubviews() {
        super.layoutSubviews()
        let squareEdgeSize = min(frame.height, frame.width)
        let buttonEdgeSize = squareEdgeSize - squareEdgeSize / 4
        button.layer.cornerRadius = buttonEdgeSize / 2
        buttonHeightConstraint?.constant = buttonEdgeSize
        buttonWidthConstraint?.constant = buttonEdgeSize
    }

    private func setup() {
        contentView.addSubview(button)
        contentView.addSubview(isTodayView)

        button
            .centerXToSuperview()
            .centerYToSuperview()

        buttonHeightConstraint = button.height(height: .zero)
        buttonWidthConstraint = button.width(width: .zero)

        isTodayView
            .height(.xs)
            .width(.xs)
            .centerX(to: button)
            .bottom(to: button, anchor: button.bottomAnchor, offset: -.xs)
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
        case .inactive:
            isTodayView.isHidden = true
            isTodayView.backgroundColor = Theme.secondaryText
            button.backgroundColor = .clear
            button.setTitleColor(Theme.secondaryText, for: .normal)
            button.isEnabled = false
            button.isHidden = true
        case .empty:
            isTodayView.backgroundColor = Theme.primaryText
            button.isHidden = false
            button.backgroundColor = .clear
            button.setTitleColor(Theme.primaryText, for: .normal)
            button.isEnabled = true
        case .filled(let dayRate):
            isTodayView.backgroundColor = Theme.reversedPrimaryText
            button.isHidden = false
            button.setTitleColor(Theme.reversedPrimaryText, for: .normal)
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
