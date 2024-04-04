import UIKit

protocol DayNoteViewControllerProtocol: AnyObject {
    func setupInitialState(dateText: String, noteText: String?, placeholder: String?)
}

final class DayNoteViewController: UIViewController {
    var presenter: DayNotePresenterProtocol?
    var textViewBottomConstraint: NSLayoutConstraint?
    var keyboardAnimationDuration: Double?

    lazy var closeButton: UIBarButtonItem = .init(
        image: .close,
        style: .plain,
        target: self,
        action: #selector(closeButtonTouchUpInside)
    )

    lazy var removeButton: UIBarButtonItem = .init(
        image: .remove,
        style: .plain,
        target: self,
        action: #selector(removeButtonTouchUpInside)
    )

    lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: .done, style: .plain, target: self, action: #selector(doneTapped))
        button.tintColor = .dPrimaryTint
        return button
    }()

    lazy var textView: UITextView = {
        let flexibleSpaceBarItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolBar = UIToolbar()
        toolBar.items = [flexibleSpaceBarItem, doneButton]
        toolBar.sizeToFit()
        let textView = UITextView()
        textView.backgroundColor = .dBackground
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.delegate = self
        textView.inputAccessoryView = toolBar
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewGoesBackground(text: textView.text)
    }

    func setup() {
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = removeButton

        view.backgroundColor = .dBackground
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

        textViewBottomConstraint = textView.bottom(
            to: view,
            anchor: view.safeAreaLayoutGuide.bottomAnchor,
            offset: -.m
        )

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
            textViewBottomConstraint?.constant = -(.m + keyboardFrame.height - view.safeAreaInsets.bottom)
            UIView.animate(withDuration: keyboardAnimationDuration ?? .zero) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }

    @objc
    func keyboardWillHide() {
        textViewBottomConstraint?.constant = -.m
        UIView.animate(withDuration: keyboardAnimationDuration ?? .zero) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    private func appMovedToBackground() {
        presenter?.viewGoesBackground(text: textView.text)
    }

    @objc
    private func doneTapped() {
        presenter?.doneTapped()
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
        placeholderLabel.isHidden = !textView.text.isEmptyOrNil
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
