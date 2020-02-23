import UIKit

struct CalendarActiveDayViewModel {
    let date: Date
}

class CalendarActiveDayCollectionVIewCell: UICollectionViewCell {
    @IBOutlet private weak var dateLabel: MediumPrimaryTextLabel!
    @IBOutlet private weak var circleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ viewModel: CalendarActiveDayViewModel) {
        dateLabel.text = viewModel.date.dateNumber
    }
}
