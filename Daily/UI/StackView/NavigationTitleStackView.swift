import UIKit

final class NavigationTitleView: UIStackView {
    override func draw(_ rect: CGRect) {
        axis = .horizontal
        spacing = 16
    }
    
    func configure(title: String, imageView: UIImageView? = nil) {
        if let imageView = imageView {
            addArrangedSubview(imageView)
        }
        
        let label = NavigationBarLable()
        label.text = title
        addArrangedSubview(label)
    }
}
