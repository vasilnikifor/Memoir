import UIKit

struct CalendarDayViewConfiguration {
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
        button.centerXToSuperview().centerYToSuperview()
        buttonHeightConstraint = button.height(height: .zero)
        buttonWidthConstraint = button.width(width: .zero)
    }

    @objc
    private func buttonTouchUpInside() {
        acton?()
    }
}

extension CalendarDayViewCell: Configurable {
    func configure(with configuration: CalendarDayViewConfiguration) {
        acton = configuration.action
        button.setTitle(configuration.date.dateNumber, for: .normal)
        button.accessibilityLabel = configuration.date.dateLongRepresentation
        button.layer.borderColor = Theme.primaryTint.cgColor
        switch configuration.state {
        case .inactive:
            button.backgroundColor = .clear
            button.setTitleColor(Theme.secondaryText, for: .normal)
            button.isEnabled = false
            button.isHidden = true
            button.layer.borderWidth = .zero
        case .empty:
            button.isHidden = false
            button.backgroundColor = .clear
            button.setTitleColor(Theme.primaryText, for: .normal)
            button.isEnabled = true
            button.layer.borderWidth = configuration.isToday ? .xxxs : .zero
        case .filled(let dayRate):
            button.isHidden = false
            button.setTitleColor(Theme.reversedPrimaryText, for: .normal)
            button.isEnabled = true
            button.layer.borderWidth = configuration.isToday ? .xxxs : .zero
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
