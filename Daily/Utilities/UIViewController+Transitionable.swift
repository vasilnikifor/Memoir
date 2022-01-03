import UIKit

extension UIViewController: Transitionable {
    func push(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func present(_ viewController: UIViewController) {
        present(UINavigationController(rootViewController: viewController), animated: true)
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
