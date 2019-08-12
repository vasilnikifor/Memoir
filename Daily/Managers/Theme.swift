import UIKit

class Theme {
    
    static var textColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.label
        } else {
            return UIColor.black
        }
    }

    static var secondoryTextColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.placeholderText
        } else {
            return UIColor.lightGray
        }
    }
    
    static let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    
}
