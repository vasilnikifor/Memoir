import UIKit

protocol CalendarViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(calendarViewModel: CalendarViewModel)
    func update()
}

final class CalendarViewController: UIViewController {
    private let rateDayButtonImage: UIImage? = UIImage(systemName: "star")
    private let addNoteButtonImage: UIImage? = UIImage(systemName: "square.and.pencil")
    private let addImageButtonImage: UIImage? = UIImage(systemName: "paperclip")
    private let takePhotoButtonImage: UIImage? = UIImage(systemName: "camera")
    
    var presenter: CalendarPresenterProtocol?
    
    private var calendarView: CalendarView = {
        return CalendarView()
    }()
    
    private lazy var rateDayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(rateDayButtonImage, for: .normal)
        button.addTarget(self, action: #selector(rateDateButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(addNoteButtonImage, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(addImageButtonImage, for: .normal)
        button.addTarget(self, action: #selector(addImageButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var takePhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(takePhotoButtonImage, for: .normal)
        button.addTarget(self, action: #selector(takePhotoButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = Theme.backgroundColor
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(rateDayButton)
        stackView.addArrangedSubview(addNoteButton)
        stackView.addArrangedSubview(addImageButton)
        stackView.addArrangedSubview(takePhotoButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(calendarView)
        view.addSubview(actionsStackView)
        
        calendarView
            .centerYToSuperview()
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
        
        actionsStackView
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview(safeArea: true)
            .height(48)
    }
    
    @objc
    private func rateDateButtonTouchUpInside() {
        presenter?.rateDayTapped()
    }
    
    @objc
    private func addNoteButtonTouchUpInside() {
        presenter?.addNoteTapped()
    }
    
    @objc
    private func addImageButtonTouchUpInside() {
        presenter?.addImageTapped()
    }
    
    @objc
    private func takePhotoButtonTouchUpInside() {
        presenter?.takePhotoTapped()
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


