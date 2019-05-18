import UIKit
import CoreData

class DayVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var dayDate: Date!
    var day: Day?
    var dayRate: Double?
    var records: [Record]?
    
    @IBOutlet weak var dayNI: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialViweSettings()
    }
    
    private func setInitialViweSettings() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.tableFooterView = UIView()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(goBack))
        view.addGestureRecognizer(rightSwipe)
        
        setViewSettings()
    }
    
    private func setViewSettings() {
        if dayDate == nil {
            dayDate = Date()
        }
        dayDateHasChanged()
    }
    
    private func dayDateHasChanged() {
        dayNI.title = getDayDateLable(date: dayDate)
        
        day = Day.getDay(date: dayDate)
        if let day = day {
            records = day.records?.sortedArray(using: [NSSortDescriptor(key: "time", ascending: true)]) as? [Record]
            dayRate = day.dayRate
        } else {
            records = nil
            dayRate = nil
        }
    }
    
    private func getDayDateLable(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: date)
    }
    
    // MARK: work with navigations
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openRecordView", let NoteRecordTableViewCell = segue.destination as? NoteVC {
            NoteRecordTableViewCell.dayDate = dayDate
            if let selectedRecord = sender as? Record {
                NoteRecordTableViewCell.record = selectedRecord
            }
        }
    }
    
    // MARK: work with tableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let records = records {
            return records.count + 1
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let records = records, indexPath.row < records.count {
            let record = records[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoteRecord", for: indexPath) as! RecordCell
            cell.recordTimeTextLabel?.text = record.time?.getTimeRepresentation()
            cell.noteTextLabel?.text = record.note ?? ""
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "AddingRecord", for: indexPath) as! AddRecordCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var sender: Record?
        if let records = records, indexPath.row < records.count {
            sender = records[indexPath.row]
        }
        performSegue(withIdentifier: "openRecordView", sender: sender)
    }
    
    // MARK: work with records
    
    @IBAction func addNoteAction(_ sender: Any) {
        addNote()
    }
    
    @IBAction func addPhotoAction(_ sender: Any) {
        addPhoto()
    }
    
    @IBAction func addImage(_ sender: Any) {
        addImage()
    }
    
    @IBAction func rateDayAction(_ sender: Any) {
        rateDay()
    }
    
    var picker = UIImagePickerController()
    
    @IBAction func addRecordButton(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let addNoteAction   = UIAlertAction(title: "Add note",          style: UIAlertAction.Style.default) {UIAlertAction in self.addNote()}
        let addCameraAction = UIAlertAction(title: "Take Photo",        style: UIAlertAction.Style.default) {UIAlertAction in self.addPhoto()}
        let addImageAction  = UIAlertAction(title: "Add from library",  style: UIAlertAction.Style.default) {UIAlertAction in self.addImage()}
        let cancelAction    = UIAlertAction(title: "Cancel",            style: UIAlertAction.Style.cancel)  {UIAlertAction in }
        
        picker.delegate = self
        
        alert.addAction(addNoteAction)
        alert.addAction(addCameraAction)
        alert.addAction(addImageAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func rateDay() {
        let alert = UIAlertController(title: "Rate the Day please",
                                      message: "O",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func setDayRate() {
        
    }
    
    private func addNote() {
        performSegue(withIdentifier: "openRecordView", sender: nil)
    }
    
    private func addPhoto() {}
    
    private func addImage() {}
}
