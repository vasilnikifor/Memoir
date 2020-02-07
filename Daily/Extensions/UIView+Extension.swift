import UIKit

extension UIView {
    class var nibName: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
