import UIKit

class NoteRecordViewController: UIViewController {
    
    // MARK: - Propertis
    
    var dayDate: Date!
    var record: NoteRecord?
    
    // MARK: - Private propertis
    
    private var noteTime: Date!
    private var isKeyboardShowed: Bool = false
    private var noteTextViewPlaceholder: String?
    
    // MARK: - Outlets
    
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var noteTextView: UITextView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewSettings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setSettingsInViewDidApper()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removePlaceholder(from: noteTextView)
        
        saveNote()
    }
    
    // MARK: - Private methods
    
    private func setViewSettings() {
        setInitialViewSettings()
        addKeyboardActions()
    }
    
    private func setSettingsInViewDidApper() {
        noteTextView?.becomeFirstResponder()
        if isTherePlaceholder(noteTextView) {
            noteTextView.setCursor(to: .start)
        }
    }
    
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
        
        initNoteTextPlaceholder()
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
        if let keyboardHeight = getKeyboardHeight(notification: notification) {
            if keyboadrdWillShow, !isKeyboardShowed {
                view.frame.size.height -= keyboardHeight
                isKeyboardShowed = true
            }
            
            if !keyboadrdWillShow, isKeyboardShowed {
                view.frame.size.height += keyboardHeight
                isKeyboardShowed = false
            }
        }
    }
    
    private func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
        guard let userInfo = notification.userInfo else { return nil }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return nil }
        return keyboardSize.cgRectValue.height
    }

    private func initNoteTextPlaceholder() {
        noteTextViewPlaceholder = getNoteTextViewPlaceholder()
        noteTextView.delegate = self
        setPlaceholder(on: noteTextView)
    }
    
    private func setPlaceholder(on textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = noteTextViewPlaceholder
            textView.textColor = Theme.secondoryTextColor
        }
    }
    
    private func removePlaceholder(from textView: UITextView) {
        if textView.text == noteTextViewPlaceholder, textView.textColor == Theme.secondoryTextColor {
            textView.text = ""
            textView.textColor = Theme.textColor
        }
    }
    
    private func getNoteTextViewPlaceholder() -> String {
        let placeholders = ["Describe your day",
                            "How are you?",
                            "How was your day today?",
                            "What activities brought you joy?",
                            "What made you smile today?",
                            "What made today unusual?",
                            "What made today a special day?",
                            "What am I grateful for right now?",
                            "What memory do you want to keep from today?",
                            "What did you realize today?"]
        
        return placeholders.randomElement()!
    }
    
    private func isTherePlaceholder(_ textView: UITextView) -> Bool {
        return textView.textColor == Theme.secondoryTextColor
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

// MARK: - UITextViewDelegate
extension NoteRecordViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = noteTextViewPlaceholder
            textView.textColor = Theme.secondoryTextColor
            textView.setCursor(to: .start)
        } else if isTherePlaceholder(textView) {
            if let text = textView.text {
                textView.text = String(text.prefix(1))
            }
            textView.textColor = Theme.textColor
        }
    }
    
}

