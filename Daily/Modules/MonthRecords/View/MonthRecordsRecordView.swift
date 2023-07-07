import UIKit

struct MonthRecordsRecordViewModel {
    let text: String
    let time: String
    let action: (() -> Void)?
}

final class MonthRecordsRecordView: UIView {
    var action: (() -> Void)?

    var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.layeredForeground
        return view
    }()

    let noteTextLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primaryMedium)
        label.numberOfLines = .zero
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .secondarySmall)
        label.numberOfLines = .zero
        return label
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
        cardView.addSubview(noteTextLabel)
        cardView.addSubview(timeLabel)

        cardView
            .topToSuperview()
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .bottomToSuperview()

        noteTextLabel
            .topToSuperview(.m)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)

        timeLabel
            .top(to: noteTextLabel, anchor: noteTextLabel.bottomAnchor, offset: .s)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
            .bottomToSuperview(-.xl)

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

extension MonthRecordsRecordView: Configurable {
    func configure(with viewModel: MonthRecordsRecordViewModel) {
        noteTextLabel.text = viewModel.text
        timeLabel.text = viewModel.time
        action = viewModel.action
    }
}
