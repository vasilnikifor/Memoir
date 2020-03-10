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
    private var time: Date = Date()
    private var noteRecord: NoteRecord?
    private var delegate: NoteRecordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Note"
        
        becomeKeyboardShowingObserver()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash") ?? UIImage(),
            style: .done,
            target: nil,
            action: #selector(removeNote)
        )
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
        time = viewModel.noteRecord?.time?.time ?? Date()
        noteRecord = viewModel.noteRecord
        
        noteTextView.text = noteRecord?.text
        timeLabel.text = time.timeRepresentation
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
            DAONoteService.createNote(dayDate: date,
                                      time: time,
                                      text: noteTextView.text)
        }
    }
    
    @objc
    private func removeNote() {
        if let noteRecord = noteRecord {
            DAONoteService.removeNote(noteRecord)
            delegate?.noteDidChange()
        } else {
            noteTextView.text = nil
        }
        dismiss()
    }
}
