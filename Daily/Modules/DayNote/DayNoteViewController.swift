import UIKit

protocol DayNoteViewControllerProtocol: Transitionable, AnyObject {
    func setupInitialState(dateText: String, noteText: String)
}

final class DayNoteViewController: UIViewController {
    var presenter: DayNotePresenterProtocol?
    
    private var textViewBottomToSuperviewBottomConstraint: NSLayoutConstraint?
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
            action: #selector(removeButtonTouchUpInside)
        )
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Theme.backgroundColor
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.delegate = self
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setup()
    }
    
    private func setup() {
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = removeButton
        
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(textView)
        
        textView
            .topToSuperview(16, safeArea: true)
            .leadingToSuperview(16)
            .trailingToSuperview(-16)
        
        textViewBottomToSuperviewBottomConstraint = textView.bottom(to: view, anchor: view.safeAreaLayoutGuide.bottomAnchor, offset: -16)
        
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
    private func keyboardWillShow(_ notification: Notification) {
        keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            textViewBottomToSuperviewBottomConstraint?.constant = -(16 + keyboardFrame.height - view.safeAreaInsets.bottom)
            UIView.animate(withDuration: keyboardAnimationDuration ?? .zero) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func keyboardWillHide() {
        textViewBottomToSuperviewBottomConstraint?.constant = -16
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
    func setupInitialState(dateText: String, noteText: String) {
        title = dateText
        textView.text = noteText
        if noteText.isEmpty {
            textView.becomeFirstResponder()
        }
    }
}

extension DayNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter?.textDidEndEditing(text: textView.text)
    }
}
