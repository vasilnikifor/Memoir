import UIKit

class AddRecordCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addImageButton.alignTextBelowImage()
        self.addPhotoButton.alignTextBelowImage()
        self.addNoteButton.alignTextBelowImage()
        self.rateDayButton.alignTextBelowImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var rateDayButton: UIButton!
    
    @IBOutlet weak var addNoteButton: UIButton!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var addImageButton: UIButton!
}
