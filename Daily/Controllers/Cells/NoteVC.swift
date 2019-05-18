
import UIKit

class NoteVC: UIViewController {

    var dayDate: Date!
    var recordTime: Date!
    var record: Record?
    
    @IBOutlet weak var timeButton: UIButton!

    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var navigationVCTitle: UINavigationItem!
    
    @IBAction func onClickSaveRecord(_ sender: Any) {
        saveRecord()
    }

    private func saveRecord() {
        if record == nil {
            record = Record.createNewRecord(day: Day.findOrCreateDay(date: dayDate), time: recordTime)
        }
        
        record!.time = recordTime
        record!.note = noteTextView.text
        
        AppDelegate.saveContext()

        goBack()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialViewSettings()
    }
    
    func viewDidAppear() {
        self.noteTextView?.becomeFirstResponder()
    }
    
    private func setInitialViewSettings() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(cansel))
        view.addGestureRecognizer(rightSwipe)
        
        //let customBackButton = UIBarButtonItem(image: UIImage(named: "previous") , style: .plain, target: self, action: #selector(cansel))
        //customBackButton.imageInsets = UIEdgeInsets(top: 2, left: -8, bottom: 0, right: 0)
        //navigationItem.leftBarButtonItem = customBackButton
        
        fillInView()
    }
    
    private func fillInView() {
        if let record = record {
            noteTextView.text = record.note
            recordTime = record.time
        } else {
            noteTextView.text = ""
            recordTime = Date()
        }
        timeButton.setTitle(recordTime.getTimeRepresentation(), for: .normal)
    }
    
    @objc private func cansel() {
        if isViewEdited() {
            let alert = UIAlertController(title: "The note was changed", message: "Would you like save the changes?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default) {UIAlertAction in self.saveRecord()})
            alert.addAction(UIAlertAction(title: "No",  style: .default) {UIAlertAction in self.goBack()})
            self.present(alert, animated: true)
        } else {
            goBack()
        }
    }
    
    private func isViewEdited() -> Bool {
        if let record = record {
            if noteTextView.text != record.note || recordTime != record.time {
                return true
            }
        } else {
            if noteTextView.text != "" {
                return true
            }
        }
        return false
    }
    
    // MARK: navigate
    
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
