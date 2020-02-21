import UIKit

protocol NoteRecordDelegate {
    func noteDidChange()
}

struct NoteRecordViewModel {
    let date: Date
    let noteRecord: NoteRecord?
}

class NoteRecordViewController: UIViewController {
    @IBOutlet private weak var timeLabel: SmallSecondaryTextLabel!
    @IBOutlet private weak var noteTextView: UITextView!
    
    private var date: Date = Date()
    private var noteRecord: NoteRecord?
    private var delegate: NoteRecordDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Note"
    }
    
    func configure(_ viewModel: NoteRecordViewModel, delegate: NoteRecordDelegate) {
        self.delegate = delegate
        
        date = viewModel.date
        noteRecord = viewModel.noteRecord
        
        if let noteRecord = noteRecord {
            timeLabel.text = noteRecord.time?.timeRepresentation
            noteTextView.text = String(noteRecord.text ?? "")
        } else {

        }
    }
}
