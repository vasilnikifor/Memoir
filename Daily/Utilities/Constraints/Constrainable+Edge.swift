import UIKit

extension Constrainable {

    // MARK: - Top

    @discardableResult
    func top(to item: Constrainable,
             anchor: NSLayoutYAxisAnchor? = nil,
             offset: CGFloat = 0,
             relation: NSLayoutConstraint.Relation = .equal,
             priority: UILayoutPriority = .required,
             isActive: Bool = true) -> NSLayoutConstraint {
        return prepare()
            .topAnchor
            .constraint(relation: relation, anchor: anchor ?? item.topAnchor, constant: offset)
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func top(to item: Constrainable,
             anchor: NSLayoutYAxisAnchor? = nil,
             offset: CGFloat = 0,
             relation: NSLayoutConstraint.Relation = .equal,
             priority: UILayoutPriority = .required) -> Constrainable {
        top(to: item, anchor: anchor, offset: offset, relation: relation, priority: priority, isActive: true)
        return self
    }

    @discardableResult
    func topToSuperview(_ offset: CGFloat = 0,
                        relation: NSLayoutConstraint.Relation = .equal,
                        priority: UILayoutPriority = .required,
                        safeArea: Bool = true) -> Constrainable {
        let safely = getSafe(container, safeArea: safeArea)
        return top(to: safely, offset: offset, relation: relation, priority: priority)
    }

    // MARK: - Bottom

    @discardableResult
    func bottom(to item: Constrainable,
                anchor: NSLayoutYAxisAnchor? = nil,
                offset: CGFloat = 0,
                relation: NSLayoutConstraint.Relation = .equal,
                priority: UILayoutPriority = .required,
                isActive: Bool = true) -> NSLayoutConstraint {
        return prepare()
            .bottomAnchor
            .constraint(relation: relation, anchor: anchor ?? item.bottomAnchor, constant: offset)
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func bottom(to item: Constrainable,
                anchor: NSLayoutYAxisAnchor? = nil,
                offset: CGFloat = 0,
                relation: NSLayoutConstraint.Relation = .equal,
                priority: UILayoutPriority = .required) -> Constrainable {
        bottom(to: item, anchor: anchor, offset: offset, relation: relation, priority: priority, isActive: true)
        return self
    }

    @discardableResult
    func bottomToSuperview(_ offset: CGFloat = 0,
                           relation: NSLayoutConstraint.Relation = .equal,
                           priority: UILayoutPriority = .required,
                           safeArea: Bool = true) -> Constrainable {
        let safely = getSafe(container, safeArea: safeArea)
        return bottom(to: safely, offset: offset, relation: relation, priority: priority)
    }

    // MARK: - Leading

    @discardableResult
    func leading(to item: Constrainable,
                 anchor: NSLayoutXAxisAnchor? = nil,
                 offset: CGFloat = 0,
                 relation: NSLayoutConstraint.Relation = .equal,
                 priority: UILayoutPriority = .required,
                 isActive: Bool = true) -> NSLayoutConstraint {
        return prepare()
            .leadingAnchor
            .constraint(relation: relation, anchor: anchor ?? item.leadingAnchor, constant: offset)
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func leading(to item: Constrainable,
                 anchor: NSLayoutXAxisAnchor? = nil,
                 offset: CGFloat = 0,
                 relation: NSLayoutConstraint.Relation = .equal,
                 priority: UILayoutPriority = .required) -> Constrainable {
        leading(to: item,
                anchor: anchor,
                offset: offset,
                relation: relation,
                priority: priority,
                isActive: true)
        return self
    }

    @discardableResult
    func leadingToSuperview(_ offset: CGFloat = 0,
                            relation: NSLayoutConstraint.Relation = .equal,
                            priority: UILayoutPriority = .required,
                            safeArea: Bool = true) -> Constrainable {

        let safely = getSafe(container, safeArea: safeArea)
        return leading(to: safely,
                       offset: offset,
                       relation: relation,
                       priority: priority)
    }

    // MARK: - Trailing

    @discardableResult
    func trailing(to item: Constrainable,
                  anchor: NSLayoutXAxisAnchor? = nil,
                  offset: CGFloat = 0,
                  relation: NSLayoutConstraint.Relation = .equal,
                  priority: UILayoutPriority = .required,
                  isActive: Bool = true) -> NSLayoutConstraint {
        return prepare()
            .trailingAnchor
            .constraint(relation: relation, anchor: anchor ?? item.trailingAnchor, constant: offset)
            .with(priority: priority)
            .set(active: isActive)
    }

    @discardableResult
    func trailing(to item: Constrainable,
                  anchor: NSLayoutXAxisAnchor? = nil,
                  offset: CGFloat = 0,
                  relation: NSLayoutConstraint.Relation = .equal,
                  priority: UILayoutPriority = .required) -> Constrainable {
        trailing(to: item, anchor: anchor, offset: offset, relation: relation, priority: priority, isActive: true)
        return self
    }

    @discardableResult
    func trailingToSuperview(_ offset: CGFloat = 0,
                             relation: NSLayoutConstraint.Relation = .equal,
                             priority: UILayoutPriority = .required,
                             safeArea: Bool = true) -> Constrainable {
        let safely = getSafe(container, safeArea: safeArea)
        return trailing(to: safely, offset: offset, relation: relation, priority: priority)
    }
}
