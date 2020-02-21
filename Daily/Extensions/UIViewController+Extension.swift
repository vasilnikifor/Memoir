import UIKit

// MARK: - View
extension UIViewController {
    static var nibName: String {
        return String(describing: self)
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            let nib = T.init(nibName: self.nibName, bundle: nil)
            nib.loadViewIfNeeded()
            return nib
        }

        return instantiateFromNib()
    }
}

// MARK: - Navigation
extension UIViewController {
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Keyboard
extension UIViewController {
    func becomeKeyboardShowingObserver() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        recognizer.cancelsTouchesInView = false
        recognizer.isEnabled = true
        view.addGestureRecognizer(recognizer)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowSelector(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc
    func keyboardWillShow(keyboardHeight: CGFloat) { }

    @objc
    func keyboardWillHide() { }
    
    @objc
    private func keyboardWillShowSelector(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        guard let height = ((userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height) else { return }
        keyboardWillShow(keyboardHeight: height)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

