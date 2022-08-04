import UIKit

protocol CalendarViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(calendarViewModel: CalendarViewModel)
    func update()
    func updateRateImage(image: UIImage)
}

final class CalendarViewController: UIViewController {
    var presenter: CalendarPresenterProtocol?
    
    let calendarContentView: UIView = {
        return UIView()
    }()
    
    var calendarView: CalendarView = {
        return CalendarView()
    }()
    
    lazy var rateDayButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.rateDayImage, for: .normal)
        button.addTarget(self, action: #selector(rateDateButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.addNoteImage, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Theme.backgroundColor
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(rateDayButton)
        stackView.addArrangedSubview(addNoteButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setup()
    }
    
    func setup() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(actionsStackView)
        view.addSubview(calendarContentView)
        calendarContentView.addSubview(calendarView)
        
        calendarContentView
            .leadingToSuperview()
            .trailingToSuperview()
            .topToSuperview()
            .bottom(to: actionsStackView, anchor: actionsStackView.topAnchor)
        
        calendarView
            .centerYToSuperview()
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
        
        actionsStackView
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview(safeArea: true)
            .height(.xxl)
    }
    
    @objc
    func rateDateButtonTouchUpInside() {
        presenter?.rateDayTapped()
    }
    
    @objc
    func addNoteButtonTouchUpInside() {
        presenter?.addNoteTapped()
    }
}

extension CalendarViewController: CalendarViewControllerProtocol {
    func setupInitialState(calendarViewModel: CalendarViewModel) {
        calendarView.setup(with: calendarViewModel)
    }
    
    func update() {
        calendarView.update()
    }
    
    func updateRateImage(image: UIImage) {
        rateDayButton.setImage(image, for: .normal)
    }
}


