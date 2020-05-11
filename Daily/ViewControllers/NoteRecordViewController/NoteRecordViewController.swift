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
        
        navigationItem.title = Localized.note
        
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
        let cancelAction = UIAlertAction(title: Localized.cansel, style: .cancel, handler: nil)
        let yesAction = UIAlertAction(title: Localized.yes, style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            if let noteRecord = self.noteRecord {
                DAONoteService.removeNote(noteRecord)
                self.delegate?.noteDidChange()
            } else {
                self.noteTextView.text = nil
            }
            
            self.dismiss()
        }
        
        let alert = UIAlertController(title: nil, message: Localized.doYouWantToDeleteTheRecord, preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        present(alert, animated: true, completion: nil)
    }
}
