import UIKit

extension UITableView {
    func dequeueReusableCell<View: UIView & ViewModelSettable>(_ viewType: View.Type) -> ReusableTableViewCell<View> {
        let identifier = String(describing: ReusableTableViewCell<View>.self)
        if let cell = dequeueReusableCell(withIdentifier: identifier) as? ReusableTableViewCell<View> {
            return cell
        } else {
            register(ReusableTableViewCell<View>.self, forCellReuseIdentifier: identifier)
            return dequeueReusableCell(viewType)
        }
    }
}
