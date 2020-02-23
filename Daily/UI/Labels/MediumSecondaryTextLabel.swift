import UIKit

final class MediumSecondaryTextLabel: BaseLabel {
    override func setSettings() {
        font = UIFont.systemFont(ofSize: 17)
        textColor = Theme.secondoryTextColor
    }
}
