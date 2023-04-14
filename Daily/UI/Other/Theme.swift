import UIKit

enum Theme {}

// MARK: - Colors
extension Theme {
    private static let white = UIColor.white
    private static let black = UIColor.black
    private static let darkGray = UIColor.systemGray6

    // MARK: -

    static var layeredBackground = UIColor(darkGray, black)
    static var layeredForeground = UIColor(white, darkGray)
    static var background = UIColor(white, black)
    static var primaryText = UIColor(black, white)
    static var reversedPrimaryText = UIColor(white, black)
    static var secondaryText: UIColor { .secondaryLabel }
    static var primaryTint = UIColor(black, white)
    static var primaryReversedTint = UIColor(white, black)
    static var badRateColor: UIColor { .systemRed }
    static var averageRateColor: UIColor { .systemBlue }
    static var goodRateColor: UIColor { .systemGreen }
    static var noRateColor: UIColor { .systemGray }
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

extension UIColor {
    convenience init(_ light: UIColor, _ dark: UIColor) {
        self.init { trait -> UIColor in
            trait.userInterfaceStyle == .light ? light : dark
        }
    }
}
