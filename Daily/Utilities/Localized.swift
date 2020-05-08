import Foundation

struct Localized {
    static let note = NSLocalizedString("note")
    
    static let dayRating = NSLocalizedString("dayRating")
    static let noRate = NSLocalizedString("No rate")
    static let badDay = NSLocalizedString("Bad day")
    static let averageDay = NSLocalizedString("Average day")
    static let goodDay = NSLocalizedString("Good day")
}

fileprivate func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
