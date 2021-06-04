import UIKit

final class CalendarViewController: UIViewController {
    private var calendarView: CalendarView = {
        return CalendarView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(calendarView)
        
        calendarView
            .centerYToSuperview()
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
    }
}


