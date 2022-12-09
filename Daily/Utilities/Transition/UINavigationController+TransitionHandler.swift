import UIKit

extension UINavigationController: TransitionHandler {
    func setRoot(_ viewController: UIViewController, animated: Bool) {
        setViewControllers([viewController], animated: animated)
    }

    func push(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }

    func present(_ viewController: UIViewController) {
        present(UINavigationController(rootViewController: viewController), animated: true)
    }

    func dismiss() {
        dismiss(animated: true)
    }
}
