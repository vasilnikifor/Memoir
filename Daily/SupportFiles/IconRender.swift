import UIKit

final class IconRender: UIViewController {
    let icon: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    let image: UIImageView = {
        let image = UIImageView()
        //image.frame = icon.bounds
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()

//    let edge: CGFloat = 20
//    let edge: CGFloat = 29
//    let edge: CGFloat = 40
//    let edge: CGFloat = 58
//    let edge: CGFloat = 60
    let edge: CGFloat = 76
//    let edge: CGFloat = 80
//    let edge: CGFloat = 87
//    let edge: CGFloat = 120
//    let edge: CGFloat = 152
//    let edge: CGFloat = 167
//    let edge: CGFloat = 180
//    let edge: CGFloat = 1024

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let gradient = CAGradientLayer()
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: .zero)
        gradient.frame = icon.bounds
        gradient.colors = [Theme.badRateColor.cgColor, Theme.averageRateColor.cgColor, Theme.goodRateColor.cgColor]

        icon.layer.insertSublayer(gradient, at: 0)

//        let ff = icon.bounds.height / 12
//
//        let label = UILabel()
//        label.frame = CGRect(
//            x: icon.bounds.minX,
//            y: icon.bounds.minY, //+ff,
//            width: icon.bounds.width,
//            height: icon.bounds.height// - ff
//        )
//
//        label.font = UIFont.boldSystemFont(ofSize: icon.bounds.height / 3)
//        label.textColor = UIColor(red: 0.56, green: 0.79, blue: 0.98, alpha: 1.00)
//        label.text = "m"
//        label.textAlignment = .center
//        icon.addSubview(label)

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
        icon.addSubview(image)

        icon
            .centerXToSuperview()
            .centerYToSuperview()
            .height(edge/3)
            .width(edge/3)

        image
            .centerXToSuperview()
            .centerYToSuperview()
            .height((edge/3)/1.3)
            .width((edge/3)/1.3)
    }
}
