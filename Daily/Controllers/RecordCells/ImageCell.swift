import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var recordTimeTextLabel: UILabel!
    @IBOutlet weak var recordImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recordImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
