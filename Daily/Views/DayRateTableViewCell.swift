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
    
    func configure(dayRate: DayRate) {
        moodImageView.image = DayRateManager.getRateImage(dayRate)
        moodImageView.tintImage(to: DayRateManager.getRateColor(dayRate))
        selectedImageView.isHidden = false
        moodNameLabel.text = DayRateManager.getRateName(dayRate)
    }
    
}
