import Foundation
import CoreData

public class Note: Record {
    
    func save() {
        AppDelegate.persistentContainer.viewContext.delete(self)
        AppDelegate.saveContext()
    }
    
    static func createNote(dayDate: Date, time: Date, text: String) -> Note {
        let day = Day.findOrCreateDay(date: dayDate)
        
        let note = Note(context: AppDelegate.persistentContainer.viewContext)
        
        note.day  = day
        note.time = time
        note.text = text
        
        AppDelegate.saveContext()
        
        return note
    }
    
}
