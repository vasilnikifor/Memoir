import UIKit

enum Theme {}

// MARK: - Colors
extension Theme {
    private static let black = UIColor.black
    private static let white = UIColor.white
    private static let darkRed = UIColor(red: 0.78, green: 0.16, blue: 0.16, alpha: 1.00) // #c62828
    private static let lightRed = UIColor(red: 0.94, green: 0.60, blue: 0.60, alpha: 1.00) // #ef9a9a
    private static let darkBlue = UIColor(red: 0.08, green: 0.40, blue: 0.75, alpha: 1.00) // #1565c0
    private static let lightBlue = UIColor(red: 0.56, green: 0.79, blue: 0.98, alpha: 1.00) // #90caf9
    private static let darkGreen = UIColor(red: 0.18, green: 0.49, blue: 0.20, alpha: 1.00) // #2e7d32
    private static let lightGreen = UIColor(red: 0.65, green: 0.84, blue: 0.65, alpha: 1.00) // #a5d6a7
    private static let darkGray = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00) // #424242
    private static let lightGray = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00) // #eeeeee
    private static let surfaceLight: UIColor =  #colorLiteral(red: 0.949019134, green: 0.9490200877, blue: 0.9705254436, alpha: 1) // #F2F2F7 // FIXME:
    private static let surfaceDark: UIColor = .black // #000000 // FIXME:

    // MARK: -
    
    static var backgroundColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? black
                : white
        }
    }

    static var foregroundColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? UIColor.systemGray6
                : white
        }
    }
    
    static var surfaceColor: UIColor {
        UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? surfaceDark
                : surfaceLight
        }
    }

    

    static var primaryTextColor: UIColor {
        UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? white
                : black
        }
    }

    static var reversedPrimaryTextColor: UIColor {
        UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? black
                : white
        }
    }


    static var secondaryTextColor: UIColor {
        return .placeholderText
    }

    static var primaryTintColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? white
                : black
        }
    }

    static var primaryReversedTintColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? black
                : white
        }
    }

    static var bottomLayerBackgroundColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? black
                : UIColor.systemGray6
        }
    }

    static var topLayerBackgroundColor: UIColor {
        return UIColor { (trait) -> UIColor in
            trait.userInterfaceStyle == .dark
                ? UIColor.systemGray6
                : white
        }
    }

    static var badRateColor: UIColor {
        return UIColor { (trait) -> UIColor in
            return UIColor.systemRed
        }
    }

    static var averageRateColor: UIColor {
        return UIColor { (trait) -> UIColor in
            return UIColor.systemBlue
        }
    }

    static var goodRateColor: UIColor {
        return UIColor { (trait) -> UIColor in
            return UIColor.systemGreen
        }
    }

    static var noRateColor: UIColor {
        return UIColor { (trait) -> UIColor in
            return UIColor.systemGray
        }
    }
}

// MARK: - Images
extension Theme {
    static var badRateImage: UIImage {
        UIImage(systemName: "hand.thumbsdown") ?? UIImage()
    }

    static var badRateFilledImage: UIImage {
        UIImage(systemName: "hand.thumbsdown.fill") ?? UIImage()
    }

    static var averageRateImage: UIImage {
        UIImage(systemName: "hand.thumbsup") ?? UIImage()
    }

    static var averageRateFilledImage: UIImage {
        UIImage(systemName: "hand.thumbsup.fill") ?? UIImage()
    }

    static var goodRateImage: UIImage {
        UIImage(systemName: "star") ?? UIImage()
    }

    static var goodRateFilledImage: UIImage {
        UIImage(systemName: "star.fill") ?? UIImage()
    }

    static var rateDayImage: UIImage {
        return UIImage(systemName: "star") ?? UIImage()
    }

    static var rateDayFilledImage: UIImage {
        return UIImage(systemName: "star.fill") ?? UIImage()
    }
    
    static var addNoteImage: UIImage {
        UIImage(systemName: "square.and.pencil") ?? UIImage()
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
