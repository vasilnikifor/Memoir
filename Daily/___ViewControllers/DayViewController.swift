import UIKit

class DayViewController: UIViewController {

    var dayDate: Date!
    
    func redarwRecords() {
        setDayData()
        
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rateDayButton: UIBarButtonItem!
    
    private var day: Day?
    private var records: [Record] = []
    private var isViewExist: Bool?
    private var imagePicker = UIImagePickerController()
    private var dayRate: DayRate?
    
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
//                noteVC.dayDate = dayDate
//                if let record = sender as? NoteRecord {
//                    noteVC.record = record
//                }
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
    
    private func dayRareDidChanged() {
        rateDayButton.image = Theme.getRateImage(dayRate, filed: false)
        
        setNavigationItemTitle()
    }
    
    private func setInitialViweSettings() {
        tableView.register(NoteRecordTableViewCell.nib, forCellReuseIdentifier: NoteRecordTableViewCell.nibName)
        tableView.register(ImageRecordTableViewCell.nib, forCellReuseIdentifier: ImageRecordTableViewCell.nibName)
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        imagePicker.delegate = self
        
        setViewSettings()
    }
    
    private func setViewSettings() {
        if dayDate == nil {
            dayDate = Date()
        }
        
        setDayData()
        
        setNavigationItemTitle()
    }
    
    private func setNavigationItemTitle() {
        if let dayRate = dayRate, dayRate != .noRate {
            let label = UILabel()
            label.text = getDayDateLable(date: dayDate)
            
            let imageView = UIImageView(image: Theme.getRateImage(dayRate))
            imageView.tintColor = Theme.getRateColor(dayRate)
            
            let titleView = UIStackView(arrangedSubviews: [imageView, label])
            titleView.axis = .horizontal
            titleView.spacing = 10.0
            
            navigationItem.titleView = titleView
        } else {
            navigationItem.title = getDayDateLable(date: dayDate)
        }
    }
    
    private func setDayData() {
        day = DAODayService.getDay(date: dayDate)
        
        if let day = day {
            dayRate = day.rate
            if let dayRedords = day.records?.sortedArray(using: [NSSortDescriptor(key: "time", ascending: true)]) as? [Record] {
                records = dayRedords
            } else {
                records = []
            }
        } else {
            records = []
            dayRate = nil
        }
        
        dayRareDidChanged()
    }
    
    private func getDayDateLable(date: Date) -> String {
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
            _ = DAOImageService.createImage(dayDate: dayDate, time: Date().time, imageData: imageData)
            redarwRecords()
        }
    }
    
    // MARK: - Actions
    
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

// MARK: - UITableViewDelegate
extension DayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = records[indexPath.row]
        
        if let noteRecord = record as? NoteRecord,
            let cell = tableView.dequeueReusableCell(withIdentifier: NoteRecordTableViewCell.nibName, for: indexPath) as?  NoteRecordTableViewCell {
            cell.configure(noteRecord: noteRecord)
            return cell
        } else if let imageRecord = record as? ImageRecord,
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageRecordTableViewCell.nibName, for: indexPath) as? ImageRecordTableViewCell {
            cell.configure(imageRecord: imageRecord)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let noteRecord = records[indexPath.row] as? NoteRecord {
            performSegue(withIdentifier: "openNoteRecordView", sender: noteRecord)
        } else if let imageRecord = records[indexPath.row] as? ImageRecord {
            performSegue(withIdentifier: "openImageRecordView", sender: imageRecord)
        }
    }
}


// MARK: - UINavigationControllerDelegate
extension DayViewController: UINavigationControllerDelegate { }


// MARK: - UIImagePickerControllerDelegate
extension DayViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.addImageRecord(image: pickedImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
