import UIKit

protocol CalendarViewControllerProtocol: AnyObject {
    func setupInitialState(calendarViewModel: CalendarViewModel)
    func update()
}

final class CalendarViewController: UIViewController {
    var presenter: CalendarPresenterProtocol?
    
    private var calendarView: CalendarView = {
        return CalendarView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(calendarView)
        
        calendarView
            .centerYToSuperview()
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
    }
}

extension CalendarViewController: CalendarViewControllerProtocol {
    func setupInitialState(calendarViewModel: CalendarViewModel) {
        calendarView.setup(with: calendarViewModel)
    }
    
    func update() {
        calendarView.update()
    }
}


