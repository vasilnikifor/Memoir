import UIKit

final class MediumPrimaryTextLabel: BaseLabel {
    override func setSettings() {
        font = UIFont.systemFont(ofSize: 17)
        textColor = Theme.primaryTextColor
    }
}
