import CoreData

final class DAONoteService: DAOService {
    @discardableResult
    static func createNote(dayDate: Date, time: Date, text: String) -> NoteRecord {
        let day = DAODayService.findOrCreateDay(date: dayDate)
        
        let noteRecord = NoteRecord(context: context)
        
        noteRecord.day = day
        noteRecord.time = time
        noteRecord.text = text
        
        saveContext()
        
        return noteRecord
    }
    
    static func removeNote(_ note: NoteRecord) {
        context.delete(note)
        saveContext()
    }
}
