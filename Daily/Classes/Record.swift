import Foundation
import CoreData


public class Record: NSManagedObject {
    static func createNewRecord(day: Day, time: Date) -> Record {
        let context = AppDelegate.persistentContainer.viewContext
        let record = Record(context: context)
        
        record.time = time
        record.day  = day
        
        AppDelegate.saveContext()
        
        return record
    }
}
