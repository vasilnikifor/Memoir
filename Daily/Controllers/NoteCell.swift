import UIKit

class NoteCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var noteTextLabel: UILabel!
    @IBOutlet weak var recordTimeTextLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
