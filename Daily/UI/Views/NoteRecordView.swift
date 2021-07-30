import UIKit

struct NoteRecordViewModel {
    let text: String
    let time: String
    let action: (() -> ())?
}

final class NoteRecordView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        addSubview(noteTextLabel)
        addSubview(timeLabel)
        
        noteTextLabel
            .topToSuperview(32)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            
        timeLabel
            .top(to: noteTextLabel, anchor: noteTextLabel.bottomAnchor, offset: 8)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            .bottomToSuperview(-20)
        
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

extension NoteRecordView: ViewModelSettable {
    func setup(with viewModel: NoteRecordViewModel) {
        noteTextLabel.text = viewModel.text
        timeLabel.text = viewModel.time
        action = viewModel.action
    }
}
