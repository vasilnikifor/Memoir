import UIKit

protocol DayRateViewControllerProtocol: AnyObject {
    func setupInitialState(dateText: String)

    func update(
        badRateViewModel: DayRateViewModel,
        averageRateViewModel: DayRateViewModel,
        goodRateViewModel: DayRateViewModel
    )
}

final class DayRateViewController: UIViewController {
    var presenter: DayRatePresenterProtocol?

    private lazy var closeButton: UIBarButtonItem = .init(
        image: .close,
        style: .plain,
        target: self,
        action: #selector(closeButtonTouchUpInside)
    )

    private lazy var removeButton: UIBarButtonItem = .init(
        image: .remove,
        style: .plain,
        target: self,
        action: #selector(removeButtonTouchUpInside)
    )

    private lazy var badRateView: DayRateView = .init()

    private lazy var averageRateView: DayRateView = .init()

    private lazy var goodRateView: DayRateView = .init()

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
        setup()
    }

    private func setup() {
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = removeButton

        view.backgroundColor = .dBackground
        view.addSubview(rateStackView)

        rateStackView
            .centerYToSuperview()
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)
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
}

extension DayRateViewController: DayRateViewControllerProtocol {
    func setupInitialState(dateText: String) {
        title = dateText
    }

    func update(
        badRateViewModel: DayRateViewModel,
        averageRateViewModel: DayRateViewModel,
        goodRateViewModel: DayRateViewModel
    ) {
        badRateView.configure(with: badRateViewModel)
        averageRateView.configure(with: averageRateViewModel)
        goodRateView.configure(with: goodRateViewModel)
    }
}
