import UIKit

final class LargeMediumBoldPrimaryTextLabel: BaseLabel {
    override func setSettings() {
        font = UIFont.boldSystemFont(ofSize: 24)
        textColor = Theme.primaryTextColor
    }
}
