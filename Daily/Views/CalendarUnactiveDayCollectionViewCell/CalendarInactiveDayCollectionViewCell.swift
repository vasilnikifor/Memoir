import UIKit

struct CalendarInactiveDayViewModel {
    let date: Date
}

class CalendarInactiveDayCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: MediumSecondaryTextLabel!
    
    func configure(_ viewModel: CalendarInactiveDayViewModel) {
        dateLabel.text = viewModel.date.dateNumber
    }
}
