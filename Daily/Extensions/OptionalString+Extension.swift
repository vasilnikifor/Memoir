import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? .empty
    }

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
