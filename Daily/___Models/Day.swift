import Foundation
import CoreData

enum DayRate: Int16, CaseIterable  {
    case noRate = 0
    case bad    = 1
    case norm   = 2
    case good   = 3
}

public class Day: NSManagedObject {
    
    var rate: DayRate {
        get {
            if let newValue = DayRate(rawValue: self.dayRate) {
                return newValue
            } else {
                return .noRate
            }
        }
        set {
            self.dayRate = newValue.rawValue
        }
    }
    
    var isEmpty: Bool {
        return (records ?? NSSet()).count == 0 && dayRate == 0
    }
    
    // MARK: - Methods
    
//    func remove() {
//        AppDelegate.persistentContainer.viewContext.delete(self)
//        AppDelegate.saveContext()
//    }
    

    
    // MARK: - Static methods
    
//    static func setDayRate(dayDate: Date, rate: DayRate) {
//        let day = Day.findOrCreateDay(date: dayDate)
//        day.rate = rate
//        if day.isEmpty() {
//            AppDelegate.persistentContainer.viewContext.delete(day)
//        }
//        AppDelegate.saveContext()
//    }
//
//    static func getDay(date: Date) -> Day? {
//        let context = AppDelegate.persistentContainer.viewContext
//        let dateForFind = date.startOfDay
//
//        let request: NSFetchRequest<Day> = Day.fetchRequest()
//        request.predicate = NSPredicate(format: "date = %@", dateForFind as CVarArg)
//
//        do {
//            let matches =  try context.fetch(request)
//            if matches.count > 0 {
//                return matches[0]
//            }
//        } catch {}
//        return nil
//    }
    
//    static func findOrCreateDay(date: Date) -> Day {
//        let context = AppDelegate.persistentContainer.viewContext
//        let dateForFind = date.startOfDay
//        
//        let request: NSFetchRequest<Day> = Day.fetchRequest()
//        request.predicate = NSPredicate(format: "date = %@", dateForFind as CVarArg)
//        
//        do {
//            let matches =  try context.fetch(request)
//            if matches.count > 0 {
//                return matches[0]
//            }
//        } catch {}
//        
//        let day = Day(context: context)
//        day.date = dateForFind
//        day.month = dateForFind.firstDayOfMonth
//        
//        AppDelegate.saveContext()
//        
//        return day
//    }
    
    static func getAllDaysOfMounth(_ month: Date) -> [Day] {
        let monthForFind = month.firstDayOfMonth
        
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "month = %@", monthForFind as CVarArg)
        
        do {
            return try AppDelegate.viewContext.fetch(request)
        } catch {}
        
        return []
    }
    
}
