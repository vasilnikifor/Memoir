import UIKit

struct CalendarWeekdayViewModel {
    let text: String
    let accessibilityLabel: String
}

final class CalendarWeekdayViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.apply(style: .primaryMedium)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.centerXToSuperview().centerYToSuperview()
    }
}

extension CalendarWeekdayViewCell: Configurable {
    func configure(with viewModel: CalendarWeekdayViewModel) {
        titleLabel.text = viewModel.text
        titleLabel.accessibilityLabel = viewModel.accessibilityLabel
    }
}
