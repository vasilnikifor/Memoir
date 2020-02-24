import UIKit

struct CalendarActiveDayViewModel {
    let date: Date
    let isHighlited: Bool
}

class CalendarActiveDayCollectionVIewCell: UICollectionViewCell {
    @IBOutlet private weak var dateLabel: MediumPrimaryTextLabel!
    @IBOutlet private weak var highlightedDateLabel: LargeMediumBoldPrimaryTextLabel!
    @IBOutlet private weak var circleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ viewModel: CalendarActiveDayViewModel) {
        if viewModel.isHighlited {
            dateLabel.text = nil
            highlightedDateLabel.text = viewModel.date.dateNumber
        } else {
            dateLabel.text = viewModel.date.dateNumber
            highlightedDateLabel.text = nil
        }
    }
}
