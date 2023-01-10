import UIKit

public extension NSLayoutAnchor {
    @objc
    @discardableResult
    func constraint(
        relation: NSLayoutConstraint.Relation,
        anchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal: return constraint(equalTo: anchor, constant: constant)
        case .lessThanOrEqual: return constraint(lessThanOrEqualTo: anchor, constant: constant)
        case .greaterThanOrEqual: return constraint(greaterThanOrEqualTo: anchor, constant: constant)
        @unknown default: fatalError("This constraint does not have this relation.")
        }
    }
}

public extension NSLayoutDimension {
    @discardableResult
    func constraint(
        relation: NSLayoutConstraint.Relation,
        dimension: NSLayoutDimension,
        multiplier: CGFloat,
        constant: CGFloat
    ) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return constraint(equalTo: dimension, multiplier: multiplier, constant: constant)
        case .lessThanOrEqual:
            return constraint(lessThanOrEqualTo: dimension, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqual:
            return constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier, constant: constant)
        @unknown default:
            fatalError("This constraint does not have this relation.")
        }
    }

    @discardableResult
    func constraint(relation: NSLayoutConstraint.Relation, constant: CGFloat) -> NSLayoutConstraint {
        switch relation {
        case .equal: return constraint(equalToConstant: constant)
        case .lessThanOrEqual: return constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqual: return constraint(greaterThanOrEqualToConstant: constant)
        @unknown default: fatalError("This constraint does not have this relation.")
        }
    }
}
