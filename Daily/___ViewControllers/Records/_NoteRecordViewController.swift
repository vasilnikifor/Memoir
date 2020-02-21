//import UIKit
//
//class NNoteRecordViewController: UIViewController {
//
//    var dayDate: Date!
//    var record: NoteRecord?
//    
//    // MARK: - Private propertis
//    
//    private var noteTime: Date!
//    private var isKeyboardShowed: Bool = false
//    
//    // MARK: - Outlets
//    
//    @IBOutlet weak var timeButton: UIButton!
//    @IBOutlet weak var noteTextView: UITextView!
//    
//    // MARK: - Life cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setViewSettings()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        saveNote()
//    }
//    
//    // MARK: - Private methods
//    
//    private func setViewSettings() {
//        setInitialViewSettings()
//        addKeyboardActions()
//    }
//    
//    private func addKeyboardActions() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        
//        view.addGestureRecognizer(tap)
//        
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide),
//                                               name: UIResponder.keyboardWillHideNotification,
//                                               object: nil)
//    }
//    
//    private func saveNote() {
//        if let note = record {
//            note.text = noteTextView.text
//            if note.isEmpty() {
//                note.remove()
//            } else {
//                note.save()
//            }
//        } else {
//            if !noteTextView.text.isEmpty {
//                _ = NoteRecord.createNote(dayDate: dayDate,
//                                    time: noteTime,
//                                    text: noteTextView.text)
//            }
//        }
//    }
//    
//    private func removeNote() {
//        if let note = record {
//            note.remove()
//            goBack()
//        } else {
//            goBack()
//        }
//    }
//    
//    private func setInitialViewSettings() {
//        fillInView()
//    }
//    
//    private func fillInView() {
//        if let note = record {
//            noteTextView.text = String(note.text ?? "")
//            noteTime = note.time
//        } else {
//            noteTextView.text = ""
//            noteTime = Date().time
//        }
//        timeButton.setTitle(noteTime.timeRepresentation, for: .normal)
//    }
//    
//    private func goBack() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    private func setViewFremeYOrigin(notification: NSNotification, keyboadrdWillShow: Bool) {
//        if let keyboardHeight = getKeyboardHeight(notification: notification) {
//            if keyboadrdWillShow, !isKeyboardShowed {
//                view.frame.size.height -= keyboardHeight
//                isKeyboardShowed = true
//            }
//            
//            if !keyboadrdWillShow, isKeyboardShowed {
//                view.frame.size.height += keyboardHeight
//                isKeyboardShowed = false
//            }
//        }
//    }
//    
//    private func getKeyboardHeight(notification: NSNotification) -> CGFloat? {
//        guard let userInfo = notification.userInfo else { return nil }
//        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return nil }
//        return keyboardSize.cgRectValue.height
//    }
//    
//    @objc private func keyboardWillShow(notification: NSNotification) {
//        setViewFremeYOrigin(notification: notification, keyboadrdWillShow: true)
//    }
//    
//    @objc private func keyboardWillHide(notification: NSNotification) {
//        setViewFremeYOrigin(notification: notification, keyboadrdWillShow: false)
//    }
//    
//    @objc private func dismissKeyboard() {
//        view.endEditing(true)
//    }
//    
//    // MARK: - actions
//    
//    @IBAction func removeNoteButtonTapped(_ sender: Any) {
//        removeNote()
//    }
//    
//}
//
//
