import UIKit

extension UILayoutGuide: Constrainable { }

public extension UILayoutGuide {
    var container: UIView? { return owningView }
}
