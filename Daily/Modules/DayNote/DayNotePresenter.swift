import Foundation

protocol DayNotePresenterProtocol: AnyObject {
    func viewLoaded()
    func closeTapped()
    func removeTapped()
    func textDidEndEditing(text: String)
}

final class DayNotePresenter {
    private weak var view: DayNoteViewControllerProtocol?
    private let dayService: DayServiceProtocol
    private let date: Date
    private var note: NoteRecord?
    private weak var delegate: CalendarDelegate?
    
    init(view: DayNoteViewControllerProtocol,
         dayService: DayServiceProtocol,
         inputModel: DayNoteInputModel) {
        self.view = view
        self.dayService = dayService
        date = inputModel.date
        note = inputModel.note
        delegate = inputModel.delegate
    }
}

extension DayNotePresenter: DayNotePresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(
            dateText: date.dateRepresentation,
            noteText: note?.text ?? ""
        )
    }
    
    func closeTapped() {
        view?.dismiss()
    }
    
    func removeTapped() {
        if let note = note { dayService.removeNote(note) }
        delegate?.update()
        view?.dismiss()
    }
    
    func textDidEndEditing(text: String) {
        note = dayService.saveNote(date: date, note: note, text: text)
        delegate?.update()
    }
}
