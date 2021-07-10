import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type) -> T {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: cellType)) as? T {
            return cell
        } else {
            register(cellType, forCellReuseIdentifier: String(describing: cellType))
            return dequeueReusableCell(cellType)
        }
    }
}
