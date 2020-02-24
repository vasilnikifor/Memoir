import UIKit

final class LargeMediumBoldPrimaryTextLabel: BaseLabel {
    override func setSettings() {
        font = UIFont.boldSystemFont(ofSize: 22)
        textColor = Theme.primaryTextColor
    }
}
