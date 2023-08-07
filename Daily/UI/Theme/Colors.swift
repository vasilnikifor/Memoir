import UIKit

extension UIColor {
    private static let white = UIColor.white
    private static let black = UIColor.black
    private static let darkGray = UIColor.systemGray6

    static var dLayeredBackground = UIColor(darkGray, black)
    static var dLayeredForeground = UIColor(white, darkGray)
    static var dBackground = UIColor(white, black)
    static var dPrimaryText = UIColor(black, white)
    static var dReversedPrimaryText = UIColor(white, black)
    static var dSecondaryText: UIColor { .secondaryLabel }
    static var dPrimaryTint = UIColor(black, white)
    static var dPrimaryReversedTint = UIColor(white, black)
    static var dBadRateColor: UIColor { .systemRed }
    static var dAverageRateColor: UIColor { .systemBlue }
    static var dGoodRateColor: UIColor { .systemGreen }
    static var dNoRateColor: UIColor { .systemGray }
}

fileprivate extension UIColor {
    convenience init(_ light: UIColor, _ dark: UIColor) {
        self.init { trait -> UIColor in
            trait.userInterfaceStyle == .light ? light : dark
        }
    }
}


