import Foundation
import CoreData

public class NoteRecord: Record {
    
    static func createNote(dayDate: Date, time: Date, text: String) -> NoteRecord {
        let day = Day.findOrCreateDay(date: dayDate)
        
        let noteRecord = NoteRecord(context: AppDelegate.persistentContainer.viewContext)
        
        noteRecord.day  = day
        noteRecord.time = time
        noteRecord.text = text
        
        AppDelegate.saveContext()
        
        return noteRecord
    }
    
}
