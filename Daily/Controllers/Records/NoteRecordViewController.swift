import UIKit

class NoteRecordViewController: UIViewController {
    
    // MARK: - propertis
    
    var dayDate: Date!
    var record: NoteRecord?
    
    // MARK: - private propertis
    
    private var noteTime: Date!
    private var isKeyboardShowed: Bool = false
    
    // MARK: - outlets
    
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialViewSettings()
        addKeyboardActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.noteTextView?.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote()
    }
    
    // MARK: - private methods
    
    private func addKeyboardActions() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func saveNote() {
        if let note = record {
            note.text = noteTextView.text
            if note.isEmpty() {
                note.remove()
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
        if let note = record {
            note.remove()
            goBack()
        } else {
            goBack()
        }
    }
    
    private func setInitialViewSettings() {
        fillInView()
    }
    
    private func fillInView() {
        if let note = record {
            noteTextView.text = String(note.text ?? "")
            noteTime = note.time
        } else {
            noteTextView.text = ""
            noteTime = Date().getTime()
        }
        timeButton.setTitle(noteTime.getTimeRepresentation(), for: .normal)
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setViewFremeYOrigin(notification: NSNotification, keyboadrdWillShow: Bool) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        if keyboadrdWillShow, !isKeyboardShowed {
            self.view.frame.size.height -= keyboardSize.cgRectValue.height
            isKeyboardShowed = true
        }
        
        if !keyboadrdWillShow, isKeyboardShowed {
            self.view.frame.size.height += keyboardSize.cgRectValue.height
            isKeyboardShowed = false
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        setViewFremeYOrigin(notification: notification, keyboadrdWillShow: true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        setViewFremeYOrigin(notification: notification, keyboadrdWillShow: false)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - actions
    
    @IBAction func removeNoteButtonTapped(_ sender: Any) {
        removeNote()
    }
    
}

