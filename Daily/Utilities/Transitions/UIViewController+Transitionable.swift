import UIKit

extension UIViewController: Transitionable {
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func present(_ viewController: UIViewController) {
        present(NavigationController(rootViewController: viewController), animated: true)
    }
    
    func dismiss() {
        guard let navigationController = navigationController else {
            dismiss(animated: true, completion: nil)
            return
        }

        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            navigationController.dismiss(animated: true, completion: nil)
        }
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

