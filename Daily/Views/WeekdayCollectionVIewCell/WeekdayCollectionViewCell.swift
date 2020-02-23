import UIKit

class WeekdayCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var weekdayNameLabel: MediumPrimaryTextLabel!
    
    func configure(weekdayName: String) {
        weekdayNameLabel.text = weekdayName
    }
}
