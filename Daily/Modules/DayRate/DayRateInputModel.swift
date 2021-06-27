import Foundation

struct DayRateInputModel {
    let date: Date
    let day: Day?
    weak var delegate: CalendarDelegate?
}
