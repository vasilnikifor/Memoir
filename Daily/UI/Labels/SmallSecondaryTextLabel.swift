import UIKit

final class SmallSecondaryTextLabel: BaseLabel {
    override func setSettings() {
        font = UIFont.systemFont(ofSize: 12)
        textColor = Theme.secondoryTextColor
    }
}
