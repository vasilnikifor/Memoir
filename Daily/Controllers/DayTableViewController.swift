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
    
        // MARK: TEST
        //TestExmpls.creatATestDay(day: day!)
        
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
            
            do {
                try AppDelegate.persistentContainer.viewContext.save()
            } catch {
                print("\(error)")
            }
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
        return records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteRecord", for: indexPath) as! NoteRecordTableViewCell
        
        let record = records[indexPath.row]
        
        cell.recordTimeTextLabel?.text = record.time?.getTimeRepresentation()
        cell.noteTextLabel?.text = record.note ?? ""

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openRecordView", sender: records[indexPath.row])
    }
}

class TestExmpls {
    static func creatATestDay(day: Day) {
        let context = AppDelegate.persistentContainer.viewContext
        TestExmpls.createRecords(day: day, context: context)
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
    }
    
    static func createRecords(day: Day, context: NSManagedObjectContext) {
//        let rec0 = Record.createNewRecord(note: "Test note text", time: Date(), day: day, context: context)
//        print(rec0)
//        let rec1 = Record.createNewRecord(note: "Adventures of Huckleberry Finn (or, in more recent editions, The Adventures of Huckleberry Finn) is a novel by Mark Twain, first published in the United Kingdom in December 1884 and in the United States in February 1885. Commonly named among the Great American Novels, the work is among the first in major American literature to be written throughout in vernacular English, characterized by local color regionalism. It is told in the first person by Huckleberry 'Huck' Finn, the narrator of two other Twain novels (Tom Sawyer Abroad and Tom Sawyer, Detective) and a friend of Tom Sawyer. It is a direct sequel to The Adventures of Tom Sawyer.", time: Date().addingTimeInterval(5.0*60.0), day: day, context: context)
//        print(rec1)
//        let rec2 = Record.createNewRecord(note: "The Adventures of Tom Sawyer by Mark Twain is an 1876 novel about a young boy growing up along the Mississippi River. It is set in the 1840s in the fictional town of St. Petersburg, inspired by Hannibal, Missouri, where Twain lived as a boy.[2] In the novel Tom Sawyer has several adventures, often with his friend, Huckleberry Finn. Originally a commercial failure, the book ended up being the best selling of any of Twain's works during his lifetime.", time: Date().addingTimeInterval(15.0*60.0), day: day, context: context)
//        print(rec2)        
    }
}
