import UIKit
import CoreData

class DayViewController: UIViewController {

    var day: Day?
    var dayDate = Date()
    
    @IBOutlet weak var dayDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillDayDateLable(date: dayDate)
        
        let context = AppDelegate.persistentContainer.viewContext
        day = Day.findOrCreateDay(date: dayDate, in: context)    }
    
    @IBOutlet var allPageView: UIView!{
        didSet {
            addGestureToAllPageView(target: self, selector: #selector(pushBack), direction: .right)
        }
    }
    
    @IBAction func craateADay(_ sender: Any) {
        let context = AppDelegate.persistentContainer.viewContext
        
        if day == nil {
            day = Day.findOrCreateDay(date: dayDate, in: context)
        }
        
        TestExmpls.createRecords(day: day!, context: context)
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
    }
    
    @IBAction func removeDay(_ sender: Any) {
        if let day = day {
            let context = AppDelegate.persistentContainer.viewContext
            Day.removeDay(day: day, context: context)
            
            do {
                try context.save()
            } catch {
                print("\(error)")
            }
        }
    }
    
    
    @objc private func pushBack() {
//        let calendarVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewController")
//        self.navigationController?.pushViewController(calendarVC!, animated: true)
    }
    
    private func addGestureToAllPageView(target: Any?, selector: Selector, direction: UISwipeGestureRecognizer.Direction) {
        let swipe = UISwipeGestureRecognizer(target: target, action: selector)
        swipe.direction = direction
        allPageView.addGestureRecognizer(swipe)
    }
    
    
    private func fillDayDateLable(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dayDateLabel.text = dateFormatter.string(from: date)
    }
    
    private func getTimeFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
}

class TestExmpls {
    //container.performBackgroundTask { context in
    
    static func createRecords(day: Day, context: NSManagedObjectContext) {
        let rec0 = Record.createNewRecord(note: "Test note text", time: Date(), day: day, context: context)
        print(rec0)
        let rec1 = Record.createNewRecord(note: "Adventures of Huckleberry Finn (or, in more recent editions, The Adventures of Huckleberry Finn) is a novel by Mark Twain, first published in the United Kingdom in December 1884 and in the United States in February 1885. Commonly named among the Great American Novels, the work is among the first in major American literature to be written throughout in vernacular English, characterized by local color regionalism. It is told in the first person by Huckleberry 'Huck' Finn, the narrator of two other Twain novels (Tom Sawyer Abroad and Tom Sawyer, Detective) and a friend of Tom Sawyer. It is a direct sequel to The Adventures of Tom Sawyer.", time: Date().addingTimeInterval(5.0*60.0), day: day, context: context)
        print(rec1)
        let rec2 = Record.createNewRecord(note: "The Adventures of Tom Sawyer by Mark Twain is an 1876 novel about a young boy growing up along the Mississippi River. It is set in the 1840s in the fictional town of St. Petersburg, inspired by Hannibal, Missouri, where Twain lived as a boy.[2] In the novel Tom Sawyer has several adventures, often with his friend, Huckleberry Finn. Originally a commercial failure, the book ended up being the best selling of any of Twain's works during his lifetime.", time: Date().addingTimeInterval(15.0*60.0), day: day, context: context)
        print(rec2)

    }
}
