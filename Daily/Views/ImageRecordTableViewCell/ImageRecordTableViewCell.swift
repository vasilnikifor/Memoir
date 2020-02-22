import UIKit

final class ImageRecordTableViewCell: UITableViewCell {
    @IBOutlet private weak var timeLabel: SmallSecondaryTextLabel!
    @IBOutlet private weak var recordImageView: UIImageView!
    
    func configure(imageRecord: ImageRecord) {
        guard let time = imageRecord.time, let imageData = imageRecord.imageData else {
            return
        }
        
        timeLabel.text = time.timeRepresentation
        recordImageView.image = UIImage(data: imageData)
    }
}
