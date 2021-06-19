import UIKit

final class NavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        navigationBar.barTintColor = Theme.backgroundColor
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
    }
}
