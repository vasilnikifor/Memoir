import Foundation
import CoreData

public class ImageRecord: Record {
    
    static func createImage(dayDate: Date, time: Date, imageData: Data) -> ImageRecord {
        let day = Day.findOrCreateDay(date: dayDate)
        
        let imageRecord = ImageRecord(context: AppDelegate.persistentContainer.viewContext)
        
        imageRecord.day       = day
        imageRecord.time      = time
        imageRecord.imageData = imageData
        
        AppDelegate.saveContext()
        
        return imageRecord
    }
    
}
