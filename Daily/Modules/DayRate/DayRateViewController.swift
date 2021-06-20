import UIKit

protocol DayRateViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(dateText: String, isRemoveable: Bool, currentRate: DayRate?)
}

final class DayRateViewController: UIViewController {
    var presenter: DayRatePresenterProtocol?
    
    private lazy var closeButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: Theme.closeImage,
            style: .plain,
            target: self,
            action: #selector(closeButtonTouchUpInside)
        )
    }()
    
    private lazy var removeButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: Theme.removeImage,
            style: .plain,
            target: self,
            action: #selector(closeButtonTouchUpInside)
        )
    }()
    
    private lazy var badRateView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Theme.badRateImage
        imageView.tintColor = Theme.badRateColor
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(badRateViewTouchUpInside)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var averageRateView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Theme.averageRateImage
        imageView.tintColor = Theme.averageRateColor
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(avaregeRateViewTouchUpInside)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var goodRateView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Theme.goodRateImage
        imageView.tintColor = Theme.goodRateColor
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(goodRateViewTouchUpInside)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var rateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(badRateView)
        stackView.addArrangedSubview(averageRateView)
        stackView.addArrangedSubview(goodRateView)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = closeButton
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(rateStackView)
        
        rateStackView
            .centerYToSuperview()
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            .height(60)
    }
    
    @objc
    private func closeButtonTouchUpInside() {
        presenter?.closeTapped()
    }
    
    @objc
    private func removeButtonTouchUpInside() {
        presenter?.removeTapped()
    }
    
    @objc
    private func badRateViewTouchUpInside() {
        presenter?.badRateTapped()
    }
    
    @objc
    private func avaregeRateViewTouchUpInside() {
        presenter?.averageRateTapped()
    }
    
    @objc
    private func goodRateViewTouchUpInside() {
        presenter?.goodRateTapped()
    }
}

extension DayRateViewController: DayRateViewControllerProtocol {
    func setupInitialState(dateText: String, isRemoveable: Bool, currentRate: DayRate?) {
        title = dateText
        if isRemoveable {
            navigationItem.rightBarButtonItem = removeButton
        }
    }
}
