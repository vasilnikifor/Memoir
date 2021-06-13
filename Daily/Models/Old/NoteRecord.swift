import CoreData

public class NoteRecord: Record {
    var isEmpty: Bool {
        if let text = text {
            return text.isEmpty
        } else {
            return true
        }
    }
}
