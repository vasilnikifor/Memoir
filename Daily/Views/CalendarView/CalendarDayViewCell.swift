import UIKit

struct CalendarDayViewModel {
    
}

final class CalendarDayViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {

    }
}

extension CalendarDayViewCell: ViewModelSettable {
    func setup(with viewModel: CalendarDayViewModel) {
        
    }
}
