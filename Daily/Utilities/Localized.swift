import Foundation

struct Localized {
    static let yes = NSLocalizedString("yes")
    static let cansel = NSLocalizedString("cancel")
    
    static let note = NSLocalizedString("note")
    
    static let dayRating = NSLocalizedString("dayRating")
    static let noRate = NSLocalizedString("noRate")
    static let badDay = NSLocalizedString("badDay")
    static let averageDay = NSLocalizedString("averageDay")
    static let goodDay = NSLocalizedString("goodDay")
    
    static let doYouWantToDeleteTheRecord = NSLocalizedString("doYouWantToDeleteTheRecord")
}

fileprivate func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
