import UIKit

extension UIViewController {
    class var nibName: String {
        return String(describing: self)
    }
    
    class func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            let nib = T.init(nibName: self.nibName, bundle: nil)
            nib.loadViewIfNeeded()
            return nib
        }

        return instantiateFromNib()
    }
    
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}
