import Foundation

struct DayRateInputModel {
    let date: Date
    let selectedRate: DayRate?
    weak var delegate: CalendarDelegate?
}
