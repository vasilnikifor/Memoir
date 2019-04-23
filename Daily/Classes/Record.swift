import Foundation
import CoreData


public class Record: NSManagedObject {
    static func createNewRecord(day: Day, time: Date) -> Record {
        let record = Record(context: AppDelegate.persistentContainer.viewContext)
        
        record.time = time
        record.day  = day
        
        return record
    }
}
