import UIKit

final class ReusableTableViewCell<View: Configurable & UIView>: UITableViewCell, Configurable {
    private let mainView = View(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(mainView)
        mainView
            .topToSuperview()
            .leadingToSuperview()
            .trailingToSuperview()
            .bottomToSuperview()
    }

    func configure(with configuration: View.Configuration) {
        mainView.configure(with: configuration)
    }
}
