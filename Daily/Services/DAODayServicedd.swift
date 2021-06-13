import CoreData

final class DAODayServicedd: DAOService {
    static func getDay(date: Date) -> DayOld? {
        let request: NSFetchRequest<DayOld> = DayOld.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", date.startOfDay as CVarArg)
        
        if let matches = try? context.fetch(request), let day = matches.first {
            return day
        } else {
            return nil
        }
    }
    
    static func removeDay(_ day: DayOld) {
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
    
    static func findOrCreateDay(date: Date) -> DayOld {
        let dateForFind = date.startOfDay
        
        let request: NSFetchRequest<DayOld> = DayOld.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", dateForFind as CVarArg)
        
        do {
            let matches =  try context.fetch(request)
            if matches.count > 0 {
                return matches[0]
            }
        } catch {}
        
        let day = DayOld(context: context)
        day.date = dateForFind
        day.month = dateForFind.firstDayOfMonth
        
        saveContext()
        
        return day
    }
    
    static func getAllDaysOfMounth(_ month: Date) -> [DayOld] {
        let monthForFind = month.firstDayOfMonth
        
        let request: NSFetchRequest<DayOld> = DayOld.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "month = %@", monthForFind as CVarArg)
        
        do {
            return try viewContext.fetch(request)
        } catch {}
        
        return []
    }
}
