import UIKit

struct MonthRecordsFooterViewModel {
    let rateImage: UIImage
    let rateTintColor: UIColor
    let rateAction: (() -> Void)?
    let addNoteAction: (() -> Void)?
}

final class MonthRecordsFooterView: UIView {
    var rateAction: (() -> Void)?
    var addNoteAction: (() -> Void)?

    var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .m
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.backgroundColor = .dLayeredForeground
        return view
    }()

    lazy var rateDayButton: UIButton = {
        let button = UIButton()
        button.setImage(.rateDay, for: .normal)
        button.addTarget(self, action: #selector(rateDateButtonTouchUpInside), for: .touchUpInside)
        return button
    }()

    lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(.addNote, for: .normal)
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
        backgroundColor = .dLayeredBackground
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

extension MonthRecordsFooterView: Configurable {
    func configure(with viewModel: MonthRecordsFooterViewModel) {
        rateDayButton.setImage(viewModel.rateImage, for: .normal)
        rateDayButton.tintColor = viewModel.rateTintColor
        rateAction = viewModel.rateAction
        addNoteAction = viewModel.addNoteAction
    }
}
