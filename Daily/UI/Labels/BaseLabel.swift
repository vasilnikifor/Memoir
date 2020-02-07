import UIKit

class BaseLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setSettings()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSettings()
    }
    
    func setSettings() { }
}
