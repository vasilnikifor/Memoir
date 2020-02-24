import UIKit

struct CalendarActiveDayViewModel {
    let date: Date
    let dayColor: UIColor
    let isHighlited: Bool
}

class CalendarActiveDayCollectionVIewCell: UICollectionViewCell {
    @IBOutlet private weak var dateLabel: MediumPrimaryTextLabel!
    @IBOutlet private weak var highlightedDateLabel: LargeMediumBoldPrimaryTextLabel!
    @IBOutlet private weak var circleView: UIView!

    func configure(_ viewModel: CalendarActiveDayViewModel) {
        circleView.backgroundColor = viewModel.dayColor
        
        if viewModel.isHighlited {
            dateLabel.text = nil
            highlightedDateLabel.text = viewModel.date.dateNumber
        } else {
            dateLabel.text = viewModel.date.dateNumber
            highlightedDateLabel.text = nil
        }
    }
}
