import UIKit

final class CalendarView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
    }
}

final class CalendarViewController: UIViewController {
    private var calendarView: CalendarView = {
        return CalendarView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(calendarView)
        
        calendarView
            .centerYToSuperview()
            
    }
}


