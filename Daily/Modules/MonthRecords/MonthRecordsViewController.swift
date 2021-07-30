import UIKit

protocol MonthRecordsViewControllerProtocol: Transitionable, AnyObject {
    
}

final class MonthRecordsViewController: UIViewController {
    var presenter: MonthRecordsPresenterProtocol?
}


extension MonthRecordsViewController: MonthRecordsViewControllerProtocol {
    
}
