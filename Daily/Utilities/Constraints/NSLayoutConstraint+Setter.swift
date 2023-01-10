import UIKit

public extension NSLayoutConstraint {
    @objc
    @discardableResult
    func with(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }

    @discardableResult
    func set(active: Bool) -> Self {
        isActive = active
        return self
    }

    @discardableResult
    func set(constant: CGFloat) -> Self {
        self.constant = constant
        return self
    }
}
