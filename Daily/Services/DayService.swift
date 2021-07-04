import CoreData

protocol DayServiceProtocol {
    func getDays(of month: Date) -> [Day]
    func rateDay(of date: Date, rate: DayRate?)
    func getDay(date: Date) -> Day?
//    func removeDay(_ day: Day)
//    func saveDay(_ day: Day)
//    func findOrCreateDay(date: Date) -> Day
}

final class DayService: DayServiceProtocol {
    func getDays(of month: Date) -> [Day] {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        let startOfTheMonthPredicate = NSPredicate(format: "date >= %@", month.firstDayOfMonth as CVarArg)
        let endOfTheMonthPredicate = NSPredicate(format: "date <= %@", month.lastDayOfMonth as CVarArg)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [startOfTheMonthPredicate, endOfTheMonthPredicate])
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            return try DAOService.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func rateDay(of date: Date, rate: DayRate?) {
        let day = findOrCreateDay(of: date)
        day.rate = rate
        saveDay(day)
    }
    
    func getDay(date: Date) -> Day? {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", date.startOfDay as CVarArg)
        if let matches = try? DAOService.context.fetch(request), let day = matches.first {
            return day
        } else {
            return nil
        }
    }

    private func removeDay(_ day: Day) {
        DAOService.context.delete(day)
        DAOService.saveContext()
    }

    private func saveDay(_ day: Day) {
        if day.isEmpty {
            removeDay(day)
        } else {
            DAOService.saveContext()
        }
    }

    private func findOrCreateDay(of date: Date) -> Day {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.predicate = NSPredicate(format: "date = %@", date.startOfDay as CVarArg)
        if let matches = try? DAOService.context.fetch(request), matches.count > 0 {
            return matches[0]
        } else {
            let day = Day(context: DAOService.context)
            day.date = date.startOfDay
            DAOService.saveContext()
            return day
        }
    }
}

