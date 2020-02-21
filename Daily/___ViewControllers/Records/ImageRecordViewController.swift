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
        
        //let pinchGesrure = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesrure))
        //imageView.addGestureRecognizer(pinchGesrure)
        
    }
    
    private func removeNote() {
        if let record = record {
            DAOImageService.removeImage(record)
            goBack()
        } else {
            goBack()
        }
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
//    @objc private func pinchGesrure(sender: UIPinchGestureRecognizer) {
//        if let senderView = sender.view {
//            senderView.transform = senderView.transform.scaledBy(x: sender.scale, y: sender.scale)
//        }
//    }
    
    // MARK: -
    
    @IBAction func removeNoteAction(_ sender: Any) {
        removeNote()
    }
    
}
