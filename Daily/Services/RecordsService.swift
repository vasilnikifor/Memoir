import Foundation

protocol RecordsServiceProtocol: AnyObject {
    func getDays(of month: Date) -> [Day]
}

final class RecordsService: RecordsServiceProtocol {
    func getDays(of month: Date) -> [Day] {
        return []
    }
}
