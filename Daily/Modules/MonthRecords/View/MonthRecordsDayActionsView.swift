import UIKit

struct MonthRecordsDayActionsViewModel {
    let rateImage: UIImage
    let rateTintColor: UIColor
    let rateAction: (() -> Void)?
    let addNoteAction: (() -> Void)?
}

final class MonthRecordsDayActionsView: UIView {
    var rateAction: (() -> Void)?
    var addNoteAction: (() -> Void)?

    var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .m
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = Theme.layeredForeground
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
        backgroundColor = Theme.layeredBackground
        addSubview(cardView)
        cardView.addSubview(actionsStackView)

        cardView
            .topToSuperview()
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .bottomToSuperview(-.s)

        actionsStackView
            .leadingToSuperview()
            .trailingToSuperview()
            .topToSuperview()
            .bottomToSuperview()
            .height(.xxl)
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

extension MonthRecordsDayActionsView: ViewModelSettable {
    func setup(with viewModel: MonthRecordsDayActionsViewModel) {
        rateDayButton.setImage(viewModel.rateImage, for: .normal)
        rateDayButton.tintColor = viewModel.rateTintColor
        rateAction = viewModel.rateAction
        addNoteAction = viewModel.addNoteAction
    }
}
