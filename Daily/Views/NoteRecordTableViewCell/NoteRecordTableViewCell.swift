import UIKit

class NoteRecordTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
    
    // MARK: - Methods
    
    func configure(noteRecord: NoteRecord) {
        timeLabel.text = noteRecord.time?.getTimeRepresentation()
        noteTextLabel.text = noteRecord.text
    }
    
}
