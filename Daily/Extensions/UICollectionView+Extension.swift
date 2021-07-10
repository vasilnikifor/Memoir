import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? T {
            return cell
        } else {
            register(cellType)
            return dequeueReusableCell(cellType, for: indexPath)
        }
    }
}
