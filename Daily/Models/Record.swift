import Foundation
import CoreData

public class Record: NSManagedObject {
    
    func save() {
        AppDelegate.saveContext()
    }
    
    func delete() {
        AppDelegate.persistentContainer.viewContext.delete(self)
        AppDelegate.saveContext()
    }
    
}
