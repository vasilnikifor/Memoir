import UIKit

final class ReusableTableViewCell<View: ViewModelSettable & UIView>: UITableViewCell, ViewModelSettable {
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

    func setup(with viewModel: View.ViewModel) {
        mainView.setup(with: viewModel)
    }
}
