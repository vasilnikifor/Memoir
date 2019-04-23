
import UIKit

class NoteRecordViewController: UIViewController {

    var record: Record?
    
    @IBOutlet weak var timeButton: UIButton!

    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillInViewFromRecord()
    }
    
    func viewDidAppear() {
        self.noteTextView?.becomeFirstResponder()
    }
    
    private func fillInViewFromRecord() {
        if let record = record {
            noteTextView.text = record.note
            timeButton.setTitle(record.time?.getTimeRepresentation(), for: .normal)
        } else {
            noteTextView.text = ""
            timeButton.setTitle(Date().getTimeRepresentation(), for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("2")
    }
}
