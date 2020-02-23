import UIKit

protocol DayRecordsListDelegat {
    func update()
}

final class DayRecordsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var recordsListToolBar: UIToolbar!
    @IBOutlet private weak var rateDayButton: UIBarButtonItem!
    
    private var date: Date = Date()
    private var records: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NoteRecordTableViewCell.nib, forCellReuseIdentifier: NoteRecordTableViewCell.nibName)
        tableView.register(ImageRecordTableViewCell.nib, forCellReuseIdentifier: ImageRecordTableViewCell.nibName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure(date: Date) {
        self.date = date
        
        update()
    }
}

// MARK: - Actions
extension DayRecordsListViewController {
    @IBAction func rateDay(_ sender: Any) {
        let rateDay = SelectRateViewController.loadFromNib()
        rateDay.configure(date: date, delegate: self)
        push(rateDay)
    }
    
    @IBAction func addNote(_ sender: Any) {
        let note = NoteRecordViewController.loadFromNib()
        note.configure(NoteRecordViewModel(date: date, noteRecord: nil), delegate: self)
        push(note)
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - DayRecordsListDelegat
extension DayRecordsListViewController: DayRecordsListDelegat {
    func update() {
        let day = DAODayService.getDay(date: date)
        
        if let dayRecords = day?.records?.sortedArray(using: [NSSortDescriptor(key: "time", ascending: true)]) as? [Record] {
            records = dayRecords
        } else {
            records = []
        }
        
        let titleView = NavigationTitleView()
        if let rate = day?.rate, rate != .noRate {
            rateDayButton.image = Theme.getRateImage(rate, filed: false)
            
            let imageView = UIImageView(image: Theme.getRateImage(rate))
            imageView.tintColor = Theme.getRateColor(rate)
            
            titleView.configure(title: date.dateRepresentation, imageView: imageView)
        } else {
            titleView.configure(title: date.dateRepresentation)
        }
        navigationItem.titleView = titleView
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension DayRecordsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let noteRecord = records[indexPath.row] as? NoteRecord {
            let noteView = NoteRecordViewController.loadFromNib()
            noteView.configure(NoteRecordViewModel(date: date, noteRecord: noteRecord), delegate: self)
            push(noteView)
        } else if let imageRecord = records[indexPath.row] as? ImageRecord {
            let imageRecordView = ImageRceordViewController.loadFromNib()
            imageRecordView.configure(ImageRecordViewModel(date: date, imageRecord: imageRecord), delegate: self)
            push(imageRecordView)
        }
    }
}

// MARK: - UITableViewDataSource
extension DayRecordsListViewController: UITableViewDataSource {
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
}

// MARK: - SelectRateDelegate
extension DayRecordsListViewController: SelectRateDelegate {
    func rateDidChange() {
        update()
    }
}

// MARK: - NoteRecordDelegate
extension DayRecordsListViewController: NoteRecordDelegate {
    func noteDidChange() {
        update()
    }
}

// MARK: - ImageRecordDelegate
extension DayRecordsListViewController: ImageRecordDelegate {
    func imageRecordDidChange() {
        update()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension DayRecordsListViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let imageData = pickedImage.jpegData(compressionQuality: 1.0) {
            _ = DAOImageService.createImage(dayDate: date, time: Date().time, imageData: imageData)
            update()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UINavigationControllerDelegate
extension DayRecordsListViewController: UINavigationControllerDelegate { }
