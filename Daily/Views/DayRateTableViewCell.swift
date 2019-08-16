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
        if #available(iOS 13.0, *) {
            moodImageView.image = UIImage(systemName: "hand.thumbsup.fill")
        } else {
            // Fallback on earlier versions
        }
        selectedImageView.isHidden = false
        moodNameLabel.text = "Norm"
    }
    
}
