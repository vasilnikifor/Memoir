import UIKit

final class IconRender: UIViewController {
    let icon: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let image: UIImageView = {
        let image = UIImageView()
        image.image = .rateDayFilled
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()

    let edge: CGFloat = 1024

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.frame = icon.bounds
        gradient.colors = [
            UIColor.dBadRateColor.cgColor,
            UIColor.dAverageRateColor.cgColor,
            UIColor.dGoodRateColor.cgColor,
        ]

        icon.layer.insertSublayer(gradient, at: 0)

        let renderer = UIGraphicsImageRenderer(bounds: icon.bounds)
        let renderedImage = renderer.image { rendererContext in
            icon.layer.render(in: rendererContext.cgContext)
        }
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        if let data = renderedImage.pngData() {
            let filename = paths.appendingPathComponent("icon\(Int(edge)).png")
            try? data.write(to: filename)
            print("filename \(filename)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(icon)
        icon.addSubview(image)

        icon
            .centerXToSuperview()
            .centerYToSuperview()
            .height(edge / 3)
            .width(edge / 3)

        image
            .centerXToSuperview()
            .centerYToSuperview()
            .height((edge / 3) / 1.3)
            .width((edge / 3) / 1.3)
    }
}
