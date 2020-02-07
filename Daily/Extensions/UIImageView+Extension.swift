import UIKit

extension UIImageView {
    func tintImage(to color: UIColor) {
        if let image = self.image {
            let templatedImage = image.withRenderingMode(.alwaysTemplate)
            self.image = templatedImage
            self.tintColor = color
        }
    }
}
