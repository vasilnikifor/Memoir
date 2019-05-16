import UIKit
import CoreData

class DayTableViewController: UITableViewController {

    var dayDate = Date() {
        didSet {
            day = Day.findOrCreateDay(date: dayDate)
            records = day.records?.sortedArray(using: [NSSortDescriptor(key: "time", ascending: true)]) as! [Record]
            dayNI.title = "\(getDayDateLable(date: day?.date ?? Date()))"
        }
    }
    var day: Day!
    var records: [Record] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "openRecordView" {
            if let NoteRecordTableViewCell = segue.destination as? NoteRecordViewController {
                var record: Record!
                if let selectedRecord = sender as? Record {
                    record = selectedRecord
                } else {
                    record = Record.createNewRecord(day: day, time: Date().getTime())
                }
                NoteRecordTableViewCell.record = record
            }
        }
    }
    
    @IBOutlet weak var dayNI: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func onGoBack(_ sender: Any) {
        goBack()
    }
    
    @IBOutlet var tableViewForm: UITableView! {
        didSet {
           addRightGestureToTableView()
        }
    }
    
    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func removeDay() {
        if let day = day {
            Day.removeDay(day: day)
        }
    }
    
    private func addRightGestureToTableView() {
        let swipe = UISwipeGestureRecognizer(target: tableViewForm, action: #selector(goBack))
        swipe.direction = UISwipeGestureRecognizer.Direction.right
        tableViewForm.addGestureRecognizer(swipe)
    }
    
    private func getDayDateLable(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: date)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == records.count {
            return tableView.dequeueReusableCell(withIdentifier: "AddingRecord", for: indexPath) as! AddingRecordTableViewCell
        }
        
        let record = records[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteRecord", for: indexPath) as! NoteRecordTableViewCell
        cell.recordTimeTextLabel?.text = record.time?.getTimeRepresentation()
        cell.noteTextLabel?.text = record.note ?? ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openRecordView", sender: records[indexPath.row])
    }
}
