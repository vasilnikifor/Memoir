import UIKit

protocol DayNoteViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(dateText: String, noteText: String, isRemoveable: Bool)
}

final class DayNoteViewController: UIViewController {
    var presenter: DayNotePresenterProtocol?
    
    private var buttonBottomToSuperviewConstraint: NSLayoutConstraint?
    private var keyboardAnimationDuration: Double?
    
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
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(Theme.doneImage, for: .normal)
        button.addTarget(self, action: #selector(doneButtonTouchUpInside), for: .touchUpInside)
        return button
    }()
    
    private var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Theme.backgroundColor
        textView.font = UIFont.systemFont(ofSize: 17)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = closeButton
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(textView)
        view.addSubview(doneButton)
        
        textView
            .topToSuperview(16, safeArea: true)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
            .bottom(to: doneButton, anchor: doneButton.topAnchor)
        
        doneButton
            .trailingToSuperview(-16)
            .height(44)
            .width(44)
        
        buttonBottomToSuperviewConstraint = doneButton.bottom(to: view, anchor: view.safeAreaLayoutGuide.bottomAnchor)
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(dismissKeyboard)
            )
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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
    private func doneButtonTouchUpInside() {

    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            buttonBottomToSuperviewConstraint?.constant = -(keyboardFrame.height - view.safeAreaInsets.bottom)
            UIView.animate(withDuration: keyboardAnimationDuration ?? .zero) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func keyboardWillHide() {
        buttonBottomToSuperviewConstraint?.constant = .zero
        UIView.animate(withDuration: keyboardAnimationDuration ?? .zero) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension DayNoteViewController: DayNoteViewControllerProtocol {
    func setupInitialState(dateText: String, noteText: String, isRemoveable: Bool) {
        title = dateText
        textView.text = noteText
        if isRemoveable {
            navigationItem.rightBarButtonItem = removeButton
        }
    }
}
