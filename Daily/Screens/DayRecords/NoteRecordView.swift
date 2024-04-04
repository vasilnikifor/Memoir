import UIKit

struct NoteRecordViewModel {
    let text: String
    let time: String
    let action: (() -> Void)?
}

final class NoteRecordView: UIView {
    private var action: (() -> Void)?

    private let noteTextLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primaryMedium)
        label.numberOfLines = .zero
        return label
    }()

    private let timeLabel: UILabel = {
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

    private func setup() {
        backgroundColor = .clear
        addSubview(noteTextLabel)
        addSubview(timeLabel)

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
    private func viewTouchUpInside() {
        action?()
    }
}

extension NoteRecordView: Configurable {
    func configure(with viewModel: NoteRecordViewModel) {
        noteTextLabel.text = viewModel.text
        timeLabel.text = viewModel.time
        action = viewModel.action
    }
}
