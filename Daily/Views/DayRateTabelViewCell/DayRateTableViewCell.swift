import UIKit

class DayRateTableViewCell: UITableViewCell {
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var moodNameLabel: UILabel!
    
    func configure(for dayRate: DayRate, isSelected: Bool) {
        moodImageView.image = Theme.getRateImage(dayRate)
        moodImageView.tintImage(to: Theme.getRateColor(dayRate))
                
        moodNameLabel.text = Theme.getRateName(dayRate)
        
        selectedImageView.isHidden = !isSelected
    }
}
