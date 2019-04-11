import Foundation
import CoreData


public class Day: NSManagedObject {
    static func findOrCreateDay(date: Date, in context: NSManagedObjectContext) -> Day {
        let dateForFind = date.getStartDay()
        
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", dateForFind as CVarArg)
        
        do {
            let matches =  try context.fetch(request)
            if matches.count > 0 {
                return matches[0]
            }
        } catch {
            print("\(error)")
        }
        
        let day = Day(context: context)
        day.date = dateForFind
        day.month = dateForFind.firstDayOfMonth()
        day.dayRate = 1
        return day
    }
    
    static func removeDay(day: Day, context: NSManagedObjectContext) {
        context.delete(day)
    }
    
    static func getAllDaysOfMounth(_ month: Date) -> [Day] {
        let monthForFind = month.firstDayOfMonth()
        
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "month = %@", monthForFind as CVarArg)
        
        do {
            return try AppDelegate.viewContext.fetch(request)
        } catch {
            print("\(error)")
        }
        return []
    }
}
