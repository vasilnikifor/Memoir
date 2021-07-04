import UIKit

protocol DayRecordsViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(dateText: String)
    func update(rateImage: UIImage)
}

final class DayRecordsViewController: UIViewController {
    var presenter: DayRecordsPresenterProtocol?
    
    private lazy var rateDayButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.rateDayImage, for: .normal)
        button.addTarget(self, action: #selector(rateDateButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.addNoteImage, for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionsStackView: UIStackView = {
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
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(actionsStackView)
        
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
}

extension DayRecordsViewController: DayRecordsViewControllerProtocol {
    func setupInitialState(dateText: String) {
        title = dateText
    }
    
    func update(rateImage: UIImage) {
        rateDayButton.setImage(rateImage, for: .normal)
    }
}
