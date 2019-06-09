import UIKit

class NoteVC: UIViewController {
    
    var dayDate: Date!
    var noteTime: Date!
    var note: Note?
    
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var navigationVCTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialViewSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.noteTextView?.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote()
    }
    
    private func saveNote() {
        if !isViewEdited() {
            return
        }
        
        if let note = note {
            note.save()
        } else {
            _ = Note.createNote(dayDate: dayDate,
                            time: noteTime,
                            text: noteTextView.text)
        }
    }
    
    private func setInitialViewSettings() {
        fillInView()
    }
    
    private func fillInView() {
        if let note = note {
            noteTextView.text = String(note.text ?? "")
            noteTime = note.time
        } else {
            noteTextView.text = ""
            noteTime = Date()
        }
        timeButton.setTitle(noteTime.getTimeRepresentation(), for: .normal)
    }
    
    private func isViewEdited() -> Bool {
        return true
        
//        if let noteRecord = note {
////            if noteTextView.text != noteRecord.text
////                || noteRecordTime != noteRecord.time {
////                return true
////            }
//        } else {
//            if noteTextView.text != "" {
//                return true
//            }
//        }
//        return false
    }
    
}

