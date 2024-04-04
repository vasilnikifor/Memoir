import CoreData

protocol DayServiceProtocol: AnyObject {
    func getDays(month: Date) -> [Day]
    func getDays(year: Date) -> [Day]
    func getDays(start: Date, end: Date) -> [Day]
    func rateDay(of date: Date, rate: DayRate?)
    func getDay(date: Date) -> Day?
    func saveNote(date: Date, note: NoteRecord?, text: String) -> NoteRecord?
    func removeNote(_ note: NoteRecord)
}

final class DayService: DayServiceProtocol {
    func getDays(month: Date) -> [Day] {
        return getDays(start: month.firstDayOfMonth, end: month.lastDayOfMonth)
    }

    func getDays(year: Date) -> [Day] {
        return getDays(start: year.firstDayOfYear, end: year.lastDayOfYear)
    }

    func getDays(start: Date, end: Date) -> [Day] {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        let startOfTheMonthPredicate = NSPredicate(format: "date >= %@", start as CVarArg)
        let endOfTheMonthPredicate = NSPredicate(format: "date <= %@", end as CVarArg)

        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [startOfTheMonthPredicate, endOfTheMonthPredicate]
        )
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

    func saveNote(date: Date, note: NoteRecord?, text: String) -> NoteRecord? {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if let note = note, text.isEmpty {
            removeNote(note)
            return nil
        } else if let note = note {
            note.text = text
            DAOService.saveContext()
            return note
        } else if !text.isEmpty {
            let day = findOrCreateDay(of: date)
            let note = NoteRecord(context: DAOService.context)
            note.day = day
            note.time = date.recordTime
            note.text = text
            DAOService.saveContext()
            return note
        } else {
            return nil
        }
    }

    func removeNote(_ note: NoteRecord) {
        DAOService.context.delete(note)
        if let day = note.day {
            saveDay(day)
        } else {
            DAOService.saveContext()
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

extension Date {
    var recordTime: Date {
        let demandedDateStartOfDay = startOfDay
        let todayStartOfDay = Date().startOfDay
        if demandedDateStartOfDay < todayStartOfDay {
            return endOfDay
        } else if demandedDateStartOfDay > todayStartOfDay {
            return demandedDateStartOfDay
        } else {
            return Date()
        }
    }
}
