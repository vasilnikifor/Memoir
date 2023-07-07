import Foundation

protocol Configurable: AnyObject {
    associatedtype Configuration
    func configure(with configuration: Configuration)
}
