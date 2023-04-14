import Foundation

struct MonthRecordsInputModel {
    let month: Date
    weak var delegate: CalendarDelegate?
}
