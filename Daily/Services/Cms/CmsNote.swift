import Foundation

protocol CmsNoteProtocol {
    var question: String { get }
}

final class CmsNote: CmsNoteProtocol {
    var question: String {
        switch Locale.currentLocale {
        case .en:
            let questions = [
                "Amazing things that happened the day…",
                "I am grateful for…",
                "What would make the day great?",
                "Daily affirmation. I am…",
                "Amazing things that happened…",
                "How could I have made the day even better?"
            ]
            return questions.randomElement() ?? ""
        }
    }
}
