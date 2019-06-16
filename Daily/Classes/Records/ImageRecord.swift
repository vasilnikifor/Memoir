import Foundation
import CoreData
import UIKit

public class ImageRecord: Record {
    
    static func createImage(dayDate: Date, time: Date, imageData: Data) -> ImageRecord {
        let day = Day.findOrCreateDay(date: dayDate)
        
        let image = ImageRecord(context: AppDelegate.persistentContainer.viewContext)
        
        image.day       = day
        image.time      = time
        image.imageData = imageData
        
        AppDelegate.saveContext()
        
        return image
    }
    
}
