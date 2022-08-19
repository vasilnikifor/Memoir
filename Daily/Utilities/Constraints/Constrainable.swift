import UIKit

protocol Constrainable {
    var container: UIView? { get }
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    @discardableResult
    func prepare() -> Self
}

extension Constrainable {
    @discardableResult
    func prepare() -> Self { return self }
    
    func getSafe(_ superview: UIView?, safeArea: Bool) -> Constrainable {
        guard let superview = superview else { fatalError("This view has no superview.") }
        
        if safeArea {
            return superview.safeAreaLayoutGuide
        } else {
            return superview
        }
    }
}
