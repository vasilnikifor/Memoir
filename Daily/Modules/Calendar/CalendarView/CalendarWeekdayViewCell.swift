import UIKit

struct CalendarWeekdayViewModel {
    let text: String
}

final class CalendarWeekdayViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.apply(style: .primary17)
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

extension CalendarWeekdayViewCell: ViewModelSettable {
    func setup(with viewModel: CalendarWeekdayViewModel) {
        titleLabel.text = viewModel.text
    }
}
