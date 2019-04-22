import UIKit

class NoteRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTextLabel: UILabel!
    
    @IBOutlet weak var recordTimeTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
