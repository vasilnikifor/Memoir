import UIKit

extension Constrainable {
    
    // MARK: - Center X
    
    @discardableResult
    func centerX(to item: Constrainable,
                 anchor: NSLayoutXAxisAnchor? = nil,
                 multiplier: CGFloat = 1,
                 offset: CGFloat = 0,
                 priority: UILayoutPriority = .required,
                 isActive: Bool = true) -> NSLayoutConstraint {
        return prepare()
            .centerXAnchor
            .constraint(equalTo: anchor ?? item.centerXAnchor, constant: offset)
            .with(priority: priority)
            .set(active: isActive)
    }
    
    @discardableResult
    func centerX(to item: Constrainable,
                 anchor: NSLayoutXAxisAnchor? = nil,
                 multiplier: CGFloat = 1,
                 offset: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Constrainable {
        centerX(to: item, anchor: anchor, multiplier: multiplier, offset: offset, priority: priority, isActive: true)
        return self
    }
    
    @discardableResult
    func centerXToSuperview(_ offset: CGFloat = 0,
                            multiplier: CGFloat = 1,
                            priority: UILayoutPriority = .required,
                            safeArea: Bool = false) -> Constrainable {
        let safely = getSafe(container, safeArea: safeArea)
        return centerX(to: safely, multiplier: multiplier, offset: offset, priority: priority)
    }
    
    // MARK: - Center Y
    
    @discardableResult
    func centerY(to item: Constrainable,
                 anchor: NSLayoutYAxisAnchor? = nil,
                 multiplier: CGFloat = 1,
                 offset: CGFloat = 0,
                 priority: UILayoutPriority = .required,
                 isActive: Bool = true) -> NSLayoutConstraint {
        return prepare()
            .centerYAnchor
            .constraint(equalTo: anchor ?? item.centerYAnchor, constant: offset)
            .with(priority: priority)
            .set(active: isActive)
    }
    
    @discardableResult
    func centerY(to item: Constrainable,
                 anchor: NSLayoutYAxisAnchor? = nil,
                 multiplier: CGFloat = 1,
                 offset: CGFloat = 0,
                 priority: UILayoutPriority = .required) -> Constrainable {
        centerY(to: item, anchor: anchor, multiplier: multiplier, offset: offset, priority: priority, isActive: true)
        return self
    }
    
    @discardableResult
    func centerYToSuperview(_ offset: CGFloat = 0,
                            multiplier: CGFloat = 1,
                            priority: UILayoutPriority = .required,
                            safeArea: Bool = false) -> Constrainable {
        let safely = getSafe(container, safeArea: safeArea)
        return centerY(to: safely, multiplier: multiplier, offset: offset, priority: priority)
    }
}
