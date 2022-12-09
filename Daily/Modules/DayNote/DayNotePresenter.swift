import Foundation

protocol DayNoteCoordinatorProtocol: AnyObject {
    func dismiss()
}

protocol DayNotePresenterProtocol: AnyObject {
    func viewLoaded()
    func viewGoesBackground(text: String)
    func closeTapped()
    func removeTapped()
    func textDidEndEditing(text: String)
}

final class DayNotePresenter {
    private weak var view: DayNoteViewControllerProtocol?
    private weak var coordinator: DayNoteCoordinatorProtocol?
    private let dayService: DayServiceProtocol
    private let analyticsService: AnalyticsServiceProtocol
    private let cms: CmsProtocol
    private let date: Date
    private var note: NoteRecord?
    private weak var delegate: CalendarDelegate?
    
    init(
        view: DayNoteViewControllerProtocol,
        coordinator: DayNoteCoordinatorProtocol,
        dayService: DayServiceProtocol,
        analyticsService: AnalyticsServiceProtocol,
        cms: CmsProtocol,
        inputModel: DayNoteInputModel
    ) {
        self.view = view
        self.coordinator = coordinator
        self.dayService = dayService
        self.analyticsService = analyticsService
        self.cms = cms
        date = inputModel.date
        note = inputModel.note
        delegate = inputModel.delegate
    }

    private func updateNote(text: String) {
        note = dayService.saveNote(date: date, note: note, text: text)
        delegate?.update()
        analyticsService.sendEvent("note_page_text_edited")
    }
}

extension DayNotePresenter: DayNotePresenterProtocol {
    func viewLoaded() {
        view?.setupInitialState(
            dateText: date.dateRepresentation,
            noteText: note?.text,
            placeholder: cms.note.question
        )
        analyticsService.sendEvent("note_page_loaded")
    }

    func viewGoesBackground(text: String) {
        updateNote(text: text)
    }

    func closeTapped() {
        coordinator?.dismiss()
    }
    
    func removeTapped() {
        coordinator?.dismiss()
        if let note = note { dayService.removeNote(note) }
        delegate?.update()
        analyticsService.sendEvent("note_page_removed")
    }
    
    func textDidEndEditing(text: String) {
        updateNote(text: text)
    }
}
