import UIKit

protocol DayRecordsViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(dateText: String)
}

final class DayRecordsViewController: UIViewController {
    var presenter: DayRecordsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.backgroundColor
    }
}

extension DayRecordsViewController: DayRecordsViewControllerProtocol {
    func setupInitialState(dateText: String) {
        title = dateText
    }
}
