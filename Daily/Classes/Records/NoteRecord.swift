import Foundation
import CoreData

public class NoteRecord: Record {
    
    static func createNote(dayDate: Date, time: Date, text: String) -> NoteRecord {
        let day = Day.findOrCreateDay(date: dayDate)
        
        let note = NoteRecord(context: AppDelegate.persistentContainer.viewContext)
        
        note.day  = day
        note.time = time
        note.text = text
        
        AppDelegate.saveContext()
        
        return note
    }
    
}
