import CoreData

class DAOImageService: DAOService {
    @discardableResult
    static func createImage(dayDate: Date, time: Date, imageData: Data) -> ImageRecord {
        let day = DAODayService.findOrCreateDay(date: dayDate)
        
        let imageRecord = ImageRecord(context: context)
        
        imageRecord.day = day
        imageRecord.time = time
        imageRecord.imageData = imageData
        
        saveContext()
        
        return imageRecord
    }
    
    static func removeImage(_ image: ImageRecord) {
        context.delete(image)
        saveContext()
    }
}
