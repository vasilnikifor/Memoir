import UIKit

class ImageCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var recordTimeTextLabel: UILabel!
    @IBOutlet weak var recordImageView: UIImageView!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recordImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
