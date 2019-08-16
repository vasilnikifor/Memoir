import Foundation
import CoreData

enum DayRate: CaseIterable  {
    case none
    case bad
    case norm
    case good
}

public class Day: NSManagedObject {
    
    // MARK: - Methods
    
    func remove() {
        AppDelegate.persistentContainer.viewContext.delete(self)
        AppDelegate.saveContext()
    }
    
    func isEmpty() -> Bool {
        return (records ?? NSSet()).count == 0 && dayRate == 0
    }
    
    // MARK: - Static methods
    
    static func setDayRate(dayDate: Date, rate: Double) {
        let day = Day.findOrCreateDay(date: dayDate)
        day.dayRate = rate
        
        if day.isEmpty() {
            AppDelegate.persistentContainer.viewContext.delete(day)
        }
        
        AppDelegate.saveContext()
    }
    
    static func getDay(date: Date) -> Day? {
        let context = AppDelegate.persistentContainer.viewContext
        let dateForFind = date.getStartDay()
        
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", dateForFind as CVarArg)
        
        do {
            let matches =  try context.fetch(request)
            if matches.count > 0 {
                return matches[0]
            }
        } catch {}
        return nil
    }
    
    static func findOrCreateDay(date: Date) -> Day {
        let context = AppDelegate.persistentContainer.viewContext
        let dateForFind = date.getStartDay()
        
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", dateForFind as CVarArg)
        
        do {
            let matches =  try context.fetch(request)
            if matches.count > 0 {
                return matches[0]
            }
        } catch {}
        
        let day = Day(context: context)
        day.date = dateForFind
        day.month = dateForFind.firstDayOfMonth()
        
        AppDelegate.saveContext()
        
        return day
    }
    
    static func getAllDaysOfMounth(_ month: Date) -> [Day] {
        let monthForFind = month.firstDayOfMonth()
        
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "month = %@", monthForFind as CVarArg)
        
        do {
            return try AppDelegate.viewContext.fetch(request)
        } catch {}
        
        return []
    }
    
}
