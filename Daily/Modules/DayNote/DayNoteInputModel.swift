import Foundation

struct DayNoteInputModel {
    let date: Date
    let note: NoteRecord?
    weak var delegate: CalendarDelegate?
}
