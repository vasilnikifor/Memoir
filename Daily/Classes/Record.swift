import Foundation
import CoreData


public class Record: NSManagedObject {
    static func createNewRecord(note: String, time: Date, day: Day, context: NSManagedObjectContext) -> Record {
        let context = AppDelegate.persistentContainer.viewContext
        let record = Record(context: context)
       
        record.note = note
        record.time = time
        record.day  = day
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
        
        return record
    }
}
