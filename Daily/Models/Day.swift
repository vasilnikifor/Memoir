import Foundation
import CoreData

enum DayRate: Int16, CaseIterable  {
    case noRate = 0
    case bad    = 1
    case norm   = 2
    case good   = 3
}

public class Day: NSManagedObject {
    var rate: DayRate {
        get {
            if let newValue = DayRate(rawValue: self.dayRate) {
                return newValue
            } else {
                return .noRate
            }
        }
        set {
            self.dayRate = newValue.rawValue
        }
    }
    
    var isEmpty: Bool {
        return (records ?? NSSet()).count == 0 && dayRate == 0
    }
}
