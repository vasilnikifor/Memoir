import UIKit

protocol TransitionHandler: AnyObject {
    func setRoot(_ viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController)
    func present(_ viewController: UIViewController)
    func dismiss()
}
