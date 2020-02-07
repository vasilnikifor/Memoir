import UIKit

final class LargePrimaryLabel: BaseLabel {
    override func setSettings() {
        font = UIFont.systemFont(ofSize: 29)
        textColor = Theme.primaryTextColor
    }
}
