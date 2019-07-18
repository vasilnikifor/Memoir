import UIKit

class DayViewController: UIViewController {

    var dayDate: Date!
    private var day: Day?
    private var dayRate: Double?
    private var records: [Record]?
    private var isViewExist: Bool?
    private var imagePicker = UIImagePickerController()
    
    // MARK: - outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rateDayButton: UIButton!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var addImageButton: UIButton!
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialViweSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isViewExist == nil {
            isViewExist = true
        } else {
            redarwRecords()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "openNoteRecordView":
            if let noteVC = segue.destination as? NoteRecordViewController {
                noteVC.dayDate = dayDate
                if let record = sender as? NoteRecord {
                    noteVC.record = record
                }
            }
            
        case "openImageRecordView":
            if let imageVC = segue.destination as? ImageRecordViewController {
                imageVC.dayDate = dayDate
                if let record = sender as? ImageRecord {
                    imageVC.record = record
                }
            }
            
        case "goToDayRater":
            if let dayRateVC = segue.destination as? DayRateViewController {
                dayRateVC.dayDate = dayDate
            }
        default:
            return
        }
    }
    
    // MARK: - methods
    
    func redarwRecords() {
        setDayData()
        
        tableView.reloadData()
    }
    
    // MARK: - private methods
    
    private func setInitialViweSettings() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.tableFooterView = UIView()
        
        rateDayButton.alignTextBelowImage()
        addNoteButton.alignTextBelowImage()
        takePhotoButton.alignTextBelowImage()
        addImageButton.alignTextBelowImage()
        
        imagePicker.delegate = self
        
        setViewSettings()
    }
    
    private func setViewSettings() {
        if dayDate == nil {
            dayDate = Date()
        }
        
        navigationItem.title = getDayDateLable(date: dayDate)
        
        setDayData()
    }
    
    private func setDayData() {
        day = Day.getDay(date: dayDate)
        
        if let day = day {
            records = day.records?.sortedArray(using: [NSSortDescriptor(key: "time", ascending: true)]) as? [Record]
            dayRate = day.dayRate
        } else {
            records = nil
            dayRate = nil
        }
    }
    
    private func getDayDateLable(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, MMM d"
        return dateFormatter.string(from: date)
    }
    
    private func rateDay() {
        performSegue(withIdentifier: "goToDayRater", sender: nil)
    }
    
    private func addNote() {
        performSegue(withIdentifier: "openNoteRecordView", sender: nil)
    }
    
    private func takePhoto() {
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    private func addImage() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }

    private func addImageRecord(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            _ = ImageRecord.createImage(dayDate: dayDate, time: Date().getTime(), imageData: imageData)
            redarwRecords()
        }
    }
    
    // MARK: - actions
    
    @IBAction func rateDayButtonTapped(_ sender: Any) {
        rateDay()
    }
    
    @IBAction func addRecordButtonTapped(_ sender: Any) {
        addRecord()
    }
    
    @IBAction func rateDayTapped(_ sender: Any) {
        rateDay()
    }
    
    @IBAction func addNoteTapped(_ sender: Any) {
        addNote()
    }
    
    @IBAction func takePhotoTapped(_ sender: Any) {
        takePhoto()
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        addImage()
    }
    
}

extension DayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let records = records {
            return records.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let records = records, indexPath.row < records.count {
            let record = records[indexPath.row]
            
            if let noteRecord = record as? NoteRecord {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoteRecord", for: indexPath) as! NoteCell
                cell.recordTimeTextLabel?.text = noteRecord.time?.getTimeRepresentation()
                cell.noteTextLabel?.text = noteRecord.text
                return cell
            } else if let imageRecord = record as? ImageRecord {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageRecord", for: indexPath) as! ImageCell
                cell.recordTimeTextLabel?.text = imageRecord.time?.getTimeRepresentation()
                cell.recordImageView?.image = UIImage(data: imageRecord.imageData!)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let records = records, indexPath.row < records.count {
            if let noteRecord = records[indexPath.row] as? NoteRecord {
                performSegue(withIdentifier: "openNoteRecordView", sender: noteRecord)
            } else if let imageRecord = records[indexPath.row] as? ImageRecord {
                performSegue(withIdentifier: "openImageRecordView", sender: imageRecord)
            }
        }
    }
    
}

// MARK: - extention UINavigationControllerDelegate

extension DayViewController: UINavigationControllerDelegate { }

// MARK: - extention UIImagePickerControllerDelegate

extension DayViewController: UIImagePickerControllerDelegate {
    
    private func addRecord() {
        let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let addNoteAction   = UIAlertAction(title: "Add note",          style: UIAlertAction.Style.default) {UIAlertAction in self.addNote()}
        let addCameraAction = UIAlertAction(title: "Take Photo",        style: UIAlertAction.Style.default) {UIAlertAction in self.takePhoto()}
        let addImageAction  = UIAlertAction(title: "Add from library",  style: UIAlertAction.Style.default) {UIAlertAction in self.addImage()}
        let cancelAction    = UIAlertAction(title: "Cancel",            style: UIAlertAction.Style.cancel)  {UIAlertAction in }
        
        imagePicker.delegate = self
        
        alert.addAction(addNoteAction)
        alert.addAction(addCameraAction)
        alert.addAction(addImageAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.addImageRecord(image: pickedImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
