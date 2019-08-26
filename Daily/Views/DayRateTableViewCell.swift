import UIKit

class DayRateTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var moodNameLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func configure(for dayRate: DayRate, isSelected: Bool) {
        moodImageView.image = Theme.getRateImage(dayRate)
        moodImageView.tintImage(to: Theme.getRateColor(dayRate))
                
        moodNameLabel.text = Theme.getRateName(dayRate)
        
        selectedImageView.isHidden = !isSelected

    }
    
}
