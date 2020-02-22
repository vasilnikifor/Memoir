import CoreData

final class DAODayService: DAOService {
    static func getDay(date: Date) -> Day? {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", date.startOfDay as CVarArg)
        
        if let matches = try? context.fetch(request), let day = matches.first {
            return day
        } else {
            return nil
        }
    }
    
    static func removeDay(_ day: Day) {
        context.delete(day)
        saveContext()
    }
    
    static func setDayRate(dayDate: Date, rate: DayRate) {
        let day = findOrCreateDay(date: dayDate)
        day.rate = rate
        if day.isEmpty {
            removeDay(day)
        }
        saveContext()
    }
    
    static func findOrCreateDay(date: Date) -> Day {
        let dateForFind = date.startOfDay
        
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
        day.month = dateForFind.firstDayOfMonth
        
        saveContext()
        
        return day
    }
    
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
