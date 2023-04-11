import Foundation
import CoreData

final public class Day: NSManagedObject {}

extension Day {
    var rate: DayRate? {
        get {
            if rateValue == 1 {
                return .bad
            } else if rateValue == 2 {
                return .average
            } else if rateValue == 3 {
                return .good
            } else {
                return nil
            }
        }

        set {
            switch newValue {
            case .none:
                rateValue = 0
            case .bad:
                rateValue = 1
            case .average:
                rateValue = 2
            case .good:
                rateValue = 3
            }
        }
    }

    var isEmpty: Bool {
        if rate == nil, (records?.count ?? .zero) == .zero {
            return true
        } else {
            return false
        }
    }
}
