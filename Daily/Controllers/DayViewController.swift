import UIKit
import CoreData

class DayViewController: UIViewController {

    var day: Day?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func craateADay(_ sender: Any) {
        let container = AppDelegate.persistentContainer
        container.performBackgroundTask { context in
            let day = Day.findOrCreateDay(date: Date(), in: context)
            do {
                try context.save()
            } catch {
                print("\(error)")
            }
            print(day)
        }
    }
}
