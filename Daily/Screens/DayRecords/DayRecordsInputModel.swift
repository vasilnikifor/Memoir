import Foundation

struct DayRecordsInputModel {
    let date: Date
    let day: Day?
    weak var delegate: CalendarDelegate?
}
