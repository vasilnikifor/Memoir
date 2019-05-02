import Foundation
import CoreData


public class Record: NSManagedObject {
    static func createNewRecord(day: Day, time: Date) -> Record {
        let context = AppDelegate.persistentContainer.viewContext
        let record = Record(context: context)
        
        record.time = time
        record.day  = day
        
        do {
            try AppDelegate.persistentContainer.viewContext.save()
        } catch {
            print("\(error)")
        }
        
        return record
    }
    
    static func saveRecord(record: Record, time: Date, note: String) {
        let context = AppDelegate.persistentContainer.viewContext


//        let request: NSFetchRequest<Day> = Day.fetchRequest()
//        request.predicate = NSPredicate(format: "date = %@", dateForFind as CVarArg)
//        
//        do {
//            let matches =  try context.fetch(request)
//            if matches.count > 0 {
//                return matches[0]
//            }
//        } catch {
//            print("\(error)")
//        }
        
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
    }
}
