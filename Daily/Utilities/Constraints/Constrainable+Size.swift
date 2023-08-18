import UIKit

extension Constrainable {
    // MARK: - Width

    @discardableResult
    func width(
        width: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        return prepare()
            .widthAnchor
            .constraint(relation: relation, constant: width)
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func width(
        _ width: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> Constrainable {
        self.width(width: width, relation: relation, priority: priority)
        return self
    }

    @discardableResult
    func width(
        to item: Constrainable,
        dimension: NSLayoutDimension? = nil,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        return prepare()
            .widthAnchor
            .constraint(
                relation: relation,
                dimension: dimension ?? item.widthAnchor,
                multiplier: multiplier,
                constant: offset
            )
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func width(
        to item: Constrainable,
        dimension: NSLayoutDimension? = nil,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> Constrainable {
        width(to: item,
              dimension: dimension,
              multiplier: multiplier,
              offset: offset,
              relation: relation,
              priority: priority,
              isActive: true)
        return self
    }

    @discardableResult
    func widthToHeight(
        of item: Constrainable,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> Constrainable {
        return width(to: item,
                     dimension: item.heightAnchor,
                     multiplier: multiplier,
                     offset: offset,
                     relation: relation,
                     priority: priority)
    }

    // MARK: - Height

    @discardableResult
    func height(
        height: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        return prepare()
            .heightAnchor
            .constraint(relation: relation, constant: height)
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func height(
        _ height: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> Constrainable {
        self.height(height: height, relation: relation, priority: priority)
        return self
    }

    @discardableResult
    func height(
        to item: Constrainable,
        dimension: NSLayoutDimension? = nil,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        isActive: Bool = true
    ) -> NSLayoutConstraint {
        return prepare()
            .heightAnchor
            .constraint(
                relation: relation,
                dimension: dimension ?? item.heightAnchor,
                multiplier: multiplier,
                constant: offset
            )
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func height(
        to item: Constrainable,
        dimension: NSLayoutDimension? = nil,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required
    ) -> Constrainable {
        height(to: item,
               dimension: dimension,
               multiplier: multiplier,
               offset: offset,
               relation: relation,
               priority: priority,
               isActive: true)
        return self
    }
}
