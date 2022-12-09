import UIKit

protocol DayNoteViewControllerProtocol: AnyObject {
    func setupInitialState(dateText: String, noteText: String?, placeholder: String?)
}

final class DayNoteViewController: UIViewController {
    var presenter: DayNotePresenterProtocol?
    var textViewBottomToSuperviewBottomConstraint: NSLayoutConstraint?
    var keyboardAnimationDuration: Double?
    
    lazy var closeButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: Theme.closeImage,
            style: .plain,
            target: self,
            action: #selector(closeButtonTouchUpInside)
        )
    }()
    
    lazy var removeButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: Theme.removeImage,
            style: .plain,
            target: self,
            action: #selector(removeButtonTouchUpInside)
        )
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Theme.backgroundColor
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.delegate = self
        return textView
    }()

    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.apply(style: .secondaryMedium)
        label.numberOfLines = .zero
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        setup()
    }
    
    func setup() {
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = removeButton
        
        view.backgroundColor = Theme.backgroundColor
        view.addSubview(textView)
        view.addSubview(placeholderLabel)
        
        textView
            .topToSuperview(.m, safeArea: true)
            .leadingToSuperview(.m)
            .trailingToSuperview(-.m)

        placeholderLabel
            .topToSuperview(.m + textView.textContainerInset.top, safeArea: true)
            .leadingToSuperview(.m + textView.textContainerInset.left + .s)
            .trailingToSuperview(-.m - textView.textContainerInset.right)
        
        textViewBottomToSuperviewBottomConstraint = textView.bottom(to: view, anchor: view.safeAreaLayoutGuide.bottomAnchor, offset: -.m)
        
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

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    @objc
    func closeButtonTouchUpInside() {
        presenter?.closeTapped()
    }
    
    @objc
    func removeButtonTouchUpInside() {
        presenter?.removeTapped()
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            textViewBottomToSuperviewBottomConstraint?.constant = -(.m + keyboardFrame.height - view.safeAreaInsets.bottom)
            UIView.animate(withDuration: keyboardAnimationDuration ?? .zero) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    func keyboardWillHide() {
        textViewBottomToSuperviewBottomConstraint?.constant = -.m
        UIView.animate(withDuration: keyboardAnimationDuration ?? .zero) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    func appMovedToBackground() {
        presenter?.viewGoesBackground(text: textView.text)
    }
}

extension DayNoteViewController: DayNoteViewControllerProtocol {
    func setupInitialState(
        dateText: String,
        noteText: String?,
        placeholder: String?
    ) {
        title = dateText
        textView.text = noteText
        if noteText.isEmptyOrNil {
            textView.becomeFirstResponder()
        }
        placeholderLabel.text = placeholder
    }
}

extension DayNoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmptyOrNil
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        presenter?.textDidEndEditing(text: textView.text)
    }
}
