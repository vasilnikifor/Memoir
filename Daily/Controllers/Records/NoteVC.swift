import UIKit

class NoteVC: UIViewController {
    
    var dayDate: Date!
    var noteTime: Date!
    var note: NoteRecord?
    
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    
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
        if let note = note {
            if (note.text ?? "").isEmpty {
                note.delete()
            } else {
                note.save()
            }
        } else {
            if !noteTextView.text.isEmpty {
                _ = NoteRecord.createNote(dayDate: dayDate,
                                    time: noteTime,
                                    text: noteTextView.text)
            }
        }
    }
    
    private func removeNote() {
        if let note = note {
            note.delete()
            goBack()
        } else {
            goBack()
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
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func removeNoteButtonTapped(_ sender: Any) {
        removeNote()
    }
    
}

