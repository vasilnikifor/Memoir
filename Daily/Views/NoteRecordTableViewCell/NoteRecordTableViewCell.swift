import UIKit

class NoteRecordTableViewCell: UITableViewCell {
    @IBOutlet private weak var timeLabel: SmallSecondaryTextLabel!
    @IBOutlet private weak var noteTextLabel: MediumPrimaryTextLabel!
    
    func configure(noteRecord: NoteRecord) {
        guard let time = noteRecord.time else {
            return
        }
        
        timeLabel.text = time.timeRepresentation
        noteTextLabel.text = noteRecord.text
    }
}
