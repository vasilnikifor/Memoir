import UIKit

final class IconRender: UIViewController {
    lazy var icon: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let edge: CGFloat = 120

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let gradient = CAGradientLayer()
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: .zero)
        gradient.frame = icon.bounds
        gradient.colors = [Theme.badRateColor.cgColor, Theme.averageRateColor.cgColor, Theme.goodRateColor.cgColor]

        icon.layer.insertSublayer(gradient, at: 0)

        let image = UIImageView()
        image.frame = icon.bounds
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        icon.addSubview(image)

        let ff = icon.bounds.height / 12

        let label = UILabel()
        label.frame = CGRect(
            x: icon.bounds.minX,
            y: icon.bounds.minY+ff,
            width: icon.bounds.width,
            height: icon.bounds.height - ff
        )

        label.font = UIFont.boldSystemFont(ofSize: icon.bounds.height / 3)
        label.textColor = UIColor(red: 0.56, green: 0.79, blue: 0.98, alpha: 1.00)
        label.text = "4"
        label.textAlignment = .center
        icon.addSubview(label)

        let renderer = UIGraphicsImageRenderer(bounds: icon.bounds)
        let renderedImage =  renderer.image { rendererContext in
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
        icon
            .centerXToSuperview()
            .centerYToSuperview()
            .height(edge/3)
            .width(edge/3)
    }
}
