import UIKit

struct NoteRecordCellViewModel {
    let text: String
    let time: String
    let action: (() -> ())?
}

final class NoteRecordCellView: UITableViewCell {
    private var action: (() -> ())?
    
    private let noteTextLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .primary17)
        label.numberOfLines = .zero
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .secondory9)
        label.numberOfLines = .zero
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(noteTextLabel)
        contentView.addSubview(timeLabel)
        
        noteTextLabel
            .topToSuperview(32)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            
        timeLabel
            .top(to: noteTextLabel, anchor: noteTextLabel.bottomAnchor, offset: 8)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            .bottomToSuperview(-20)
        
        contentView.addGestureRecognizer(
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

extension NoteRecordCellView: ViewModelSettable {
    func setup(with viewModel: NoteRecordCellViewModel) {
        noteTextLabel.text = viewModel.text
        timeLabel.text = viewModel.time
        action = viewModel.action
    }
}
