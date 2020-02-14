import UIKit

final class NavigationBarLable: BaseLabel {
    override func setSettings() {
        font = UIFont.boldSystemFont(ofSize: 17)
        textColor = Theme.primaryTextColor
    }
}
