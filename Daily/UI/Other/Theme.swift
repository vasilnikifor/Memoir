import UIKit

enum Theme {
}

// MARK: - Colors
extension Theme {
    static var primaryTextColor: UIColor {
        return .label
    }

    static var secondoryTextColor: UIColor {
        return .placeholderText
    }
    
    static var backgroundColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? .black
                : .white
        }
    }
    
    static var badRateColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.78, green: 0.16, blue: 0.16, alpha: 1.00) // #c62828
                : UIColor(red: 0.94, green: 0.60, blue: 0.60, alpha: 1.00) // #ef9a9a
        }
    }
    
    static var averageRateColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.08, green: 0.40, blue: 0.75, alpha: 1.00) // #1565c0
                : UIColor(red: 0.56, green: 0.79, blue: 0.98, alpha: 1.00) // #90caf9
        }
    }
    
    static var goodRateColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.18, green: 0.49, blue: 0.20, alpha: 1.00) // #2e7d32
                : UIColor(red: 0.65, green: 0.84, blue: 0.65, alpha: 1.00) // #a5d6a7
        }
    }
    
    static var noRateColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00) // #424242
                : UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00) // #eeeeee
        }
    }
}

// MARK: - Images
extension Theme {
    static var badRateImage: UIImage {
        return UIImage(systemName: "star.slash") ?? UIImage()
    }
    
    static var averageRateImage: UIImage {
        return UIImage(systemName: "star.leadinghalf.fill") ?? UIImage()
    }
    
    static var goodRateImage: UIImage {
        return UIImage(systemName: "star.fill") ?? UIImage()
    }
    
    static var noRateImage: UIImage {
        return UIImage(systemName: "star") ?? UIImage()
    }
    
    static var closeImage: UIImage {
        return UIImage(systemName: "xmark") ?? UIImage()
    }
    
    static var removeImage: UIImage {
        return UIImage(systemName: "trash") ?? UIImage()
    }
    
    static var doneImage: UIImage {
        return UIImage(systemName: "checkmark") ?? UIImage()
    }
}
