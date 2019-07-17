import UIKit

class ImageRecordViewController: UIViewController {

    var dayDate: Date!
    var record: ImageRecord?
    
    // MARK: -
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewSettings()
    }
    
    // MARK: -
    
    private func setViewSettings() {
        if let record = record {
            imageView.image = UIImage(data: record.imageData!)
        }
        
    }

    private func removeNote() {
        if let record = record {
            record.delete()
            goBack()
        } else {
            goBack()
        }
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: -
    
    @IBAction func removeNoteAction(_ sender: Any) {
        removeNote()
    }
    
}
