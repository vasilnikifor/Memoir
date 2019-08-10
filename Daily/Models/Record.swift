import Foundation
import CoreData

public class Record: NSManagedObject {
    
    // MARK: - Methods
    
    func save() {
        AppDelegate.saveContext()
    }
    
    func remove() {
        
        let recordDay = self.day
        
        AppDelegate.persistentContainer.viewContext.delete(self)
        AppDelegate.saveContext()
        
        if let recordDay = recordDay, recordDay.isEmpty() {
            recordDay.remove()
        }
    }
    
}
