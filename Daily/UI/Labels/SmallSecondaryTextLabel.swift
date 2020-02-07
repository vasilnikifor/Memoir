import UIKit

final class SmallSecondaryTextLabel: BaseLabel {
    override func setSettings() {
        font = UIFont.systemFont(ofSize: 10)
        textColor = Theme.secondoryTextColor
    }
}
