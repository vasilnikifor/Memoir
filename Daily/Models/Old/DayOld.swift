import Foundation
import CoreData



public class DayOld: NSManagedObject {
    var rate: DayRate {
        get {
            .bad
//            if let newValue = DayRate(rawValue: self.dayRate) {
//                return newValue
//            } else {
//                return .norm
//            }
        }
        set {
            //self.dayRate = newValue.rawValue
        }
    }
    
    var isEmpty: Bool {
        return false //(records ?? NSSet()).count == 0 && rate == .noRate
    }
}
