import UIKit

protocol Transitionable {
    func push(_ viewController: UIViewController)
    func present(_ viewController: UIViewController)
    func dismiss()
}
