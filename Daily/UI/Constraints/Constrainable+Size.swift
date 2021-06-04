import UIKit

extension Constrainable {

    // MARK: - Width

    @discardableResult
    func width(width: CGFloat,
               relation: NSLayoutConstraint.Relation = .equal,
               priority: UILayoutPriority = .required,
               isActive: Bool = true) -> NSLayoutConstraint {
        return prepare()
            .widthAnchor
            .constraint(relation: relation, constant: width)
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func width(_ width: CGFloat,
               relation: NSLayoutConstraint.Relation = .equal,
               priority: UILayoutPriority = .required) -> Constrainable {
        self.width(width: width, relation: relation, priority: priority)
        return self
    }

    // MARK: - Height

    @discardableResult
    func height(height: CGFloat,
                relation: NSLayoutConstraint.Relation = .equal,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {
        return prepare()
            .heightAnchor
            .constraint(relation: relation, constant: height)
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func height(_ height: CGFloat,
                relation: NSLayoutConstraint.Relation = .equal,
                priority: UILayoutPriority = .required) -> Constrainable {
        self.height(height: height, relation: relation, priority: priority)
        return self
    }
}
