import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var noteTextLabel: UILabel!
    @IBOutlet weak var recordTimeTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
