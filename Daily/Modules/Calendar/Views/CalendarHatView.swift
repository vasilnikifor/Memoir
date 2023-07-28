import UIKit

final class CalendarHatView: UIView {
    var onNextMonthTap: (() -> Void)?
    var onPreviousMonthTap: (() -> Void)?
    var onCurrentMonthTap: (() -> Void)?

    var previousMonthAccessibilityLabel: String? {
        didSet {
            previousMonthButton.accessibilityLabel = previousMonthAccessibilityLabel
        }
    }

    var nextMonthAccessibilityLabel: String? {
        didSet {
            nextMonthButton.accessibilityLabel = nextMonthAccessibilityLabel
        }
    }

    var currentMonthButtonTitle: String? {
        didSet {
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]
            let attributedString = NSAttributedString(string: currentMonthButtonTitle ?? .empty, attributes: attributes)
            currentMonthButton.setAttributedTitle(attributedString, for: .normal)
        }
    }

    private lazy var previousMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.arrowLeftImage, for: .normal)
        button.addTarget(self, action: #selector(previousMonthButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = .s
        return button
    }()

    private lazy var nextMonthButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.arrowRightImage, for: .normal)
        button.addTarget(self, action: #selector(nextMonthButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = .s
        return button
    }()

    private lazy var currentMonthButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.imagePlacement = .trailing
        configuration.imagePadding = .m
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
        button.setImage(Theme.arrowOpenImage, for: .normal)
        button.layer.cornerRadius = .s
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

    private func setup() {
        addSubview(nextMonthButton)
        addSubview(previousMonthButton)
        addSubview(currentMonthButton)

        height(.xl)

        previousMonthButton
            .topToSuperview()
            .leadingToSuperview()
            .height(.xl)
            .width(.xl)

        nextMonthButton
            .topToSuperview()
            .trailingToSuperview()
            .height(.xl)
            .width(.xl)

        currentMonthButton
            .topToSuperview()
            .leading(to: previousMonthButton, anchor: previousMonthButton.trailingAnchor, offset: .s)
            .trailing(to: nextMonthButton, anchor: nextMonthButton.leadingAnchor, offset: -.s)
            .height(.xl)
    }

    @objc
    private func nextMonthButtonTapped() {
        onNextMonthTap?()
    }

    @objc
    private func previousMonthButtonTapped() {
        onPreviousMonthTap?()
    }

    @objc
    private func currentButtonTapped() {
        onCurrentMonthTap?()
    }
}
