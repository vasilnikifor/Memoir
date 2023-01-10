import UIKit

extension UIView: Constrainable { }

extension UIView {
    var container: UIView? { return superview }

    @discardableResult
    func prepare() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func constraint(for attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        var item: UIView? = self.superview
        if attribute == .width || attribute == .height { item = self }

        return item?
            .constraints
            .map { [($0, $0.firstItem as? UIView, $0.firstAttribute), ($0, $0.secondItem as? UIView, $0.secondAttribute)] }
            .reduce([], +)
            .filter { $0.1 == self && $0.2 == attribute }
            .map { $0.0 }
            .first
    }
}
