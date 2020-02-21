import UIKit

protocol NoteRecordDelegate {
    func noteDidChange()
}

struct NoteRecordViewModel {
    let date: Date
    let noteRecord: NoteRecord?
}

final class NoteRecordViewController: UIViewController {
    @IBOutlet private weak var timeLabel: SmallSecondaryTextLabel!
    @IBOutlet private weak var noteTextView: UITextView!
    @IBOutlet private weak var noteTextViewBottomConstratint: NSLayoutConstraint!
    
    private var date: Date = Date()
    private var noteRecord: NoteRecord?
    private var delegate: NoteRecordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Note"
        
        becomeKeyboardShowingObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        noteTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote()
        delegate?.noteDidChange()
    }
    
    override func keyboardWillShow(keyboardHeight: CGFloat) {
        self.noteTextViewBottomConstratint.constant = keyboardHeight
        self.view.layoutIfNeeded()
    }
    
    override func keyboardWillHide() {
        self.noteTextViewBottomConstratint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    func configure(_ viewModel: NoteRecordViewModel, delegate: NoteRecordDelegate) {
        self.delegate = delegate
        
        date = viewModel.date
        noteRecord = viewModel.noteRecord
        
        if let noteRecord = noteRecord, let time = noteRecord.time, let text = noteRecord.text {
            timeLabel.text = time.timeRepresentation
            noteTextView.text = text
        } else {
            timeLabel.text = Date().timeRepresentation
            noteTextView.text = nil
        }
    }
}

// MARK: - Private methods
extension NoteRecordViewController {
    private func saveNote() {
        if let noteRecord = noteRecord {
            noteRecord.text = noteTextView.text
            if noteRecord.isEmpty {
                DAONoteService.removeNote(noteRecord)
            } else {
                DAOService.saveContext()
            }
        } else if !noteTextView.text.isEmpty {
            _ = DAONoteService.createNote(dayDate: date,
                                          time: Date().time,
                                          text: noteTextView.text)
        }
    }
}
