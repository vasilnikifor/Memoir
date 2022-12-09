import Foundation

protocol CmsNoteProtocol {
    var question: String { get }
}

final class CmsNote: CmsNoteProtocol {
    var question: String {
        switch Locale.currentLocale {
        case .en:
            let questions = [
                "What are all the things you're grateful for today?",
                "What is your favorite activity for today?",
                "What was something positive you experienced recently?",
                "What are three good things about today?",
                "What are some random acts of kindness that you have done today?",
                "What are some things that give your life meaning today?"
            ]
            return questions.randomElement() ?? ""
        }
    }
}
