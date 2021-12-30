import UIKit

struct NoteRecordViewModel {
    let text: String
    let time: String
    let action: (() -> ())?
}

final class NoteRecordView: UIView {
    var action: (() -> ())?
    
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
        backgroundColor = .clear
        addSubview(noteTextLabel)
        addSubview(timeLabel)
        
        noteTextLabel
            .topToSuperview(16)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            
        timeLabel
            .top(to: noteTextLabel, anchor: noteTextLabel.bottomAnchor, offset: 8)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            .bottomToSuperview(-32)
        
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

extension NoteRecordView: ViewModelSettable {
    func setup(with viewModel: NoteRecordViewModel) {
        noteTextLabel.text = viewModel.text
        timeLabel.text = viewModel.time
        action = viewModel.action
    }
}
