//    import UIKit
//
//    protocol DayRecordsListDelegat {
//        func update()
//    }
//
//    final class DayRecordsListViewController: UIViewController {
//        @IBOutlet private weak var tableView: UITableView!
//        @IBOutlet private weak var recordsListToolBar: UIToolbar!
//        @IBOutlet private weak var rateDayButton: UIBarButtonItem!
//        
//        private var date: Date = Date()
//        private var records: [Record] = []
//        //private var delegate: CalendarDelegate?
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            
//            tableView.rowHeight = UITableView.automaticDimension
//            tableView.tableFooterView = UIView()
//            tableView.delegate = self
//            tableView.dataSource = self
//        }
//        
//        func configure(date: Date) { //}, delegate: CalendarDelegate) {
//            self.date = date
//            //self.delegate = delegate
//            
//            update()
//        }
//    }
//
//    // MARK: - Actions
//    extension DayRecordsListViewController {
//        @IBAction func rateDay(_ sender: Any) {
//
//        }
//        
//        @IBAction func addNote(_ sender: Any) {
//
//        }
//        
//        @IBAction func takePhoto(_ sender: Any) {
//            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
//                return
//            }
//            
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerController.SourceType.camera
//            present(imagePicker)
//        }
//        
//        @IBAction func addImage(_ sender: Any) {
//            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
//                return
//            }
//            
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//            present(imagePicker)
//        }
//    }
//
//    // MARK: - DayRecordsListDelegat
//    extension DayRecordsListViewController: DayRecordsListDelegat {
//        func update() {
//            let day = DAODayService.getDay(date: date)
//            
//            if let dayRecords = day?.records?.sortedArray(using: [NSSortDescriptor(key: "time", ascending: true)]) as? [Record] {
//                records = dayRecords
//            } else {
//                records = []
//            }
//            
//            //rateDayButton.image = Theme.getRateImage(day?.rate, filed: false)
//            
//            tableView.reloadData()
//            
//            //delegate?.update()
//        }
//    }
//
//    // MARK: - UITableViewDelegate
//    extension DayRecordsListViewController: UITableViewDelegate {
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        }
//    }
//
//    // MARK: - UITableViewDataSource
//    extension DayRecordsListViewController: UITableViewDataSource {
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return records.count
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            return UITableViewCell()
//        }
//    }
//    // MARK: - UIImagePickerControllerDelegate
//    extension DayRecordsListViewController: UIImagePickerControllerDelegate {
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
//                let imageData = pickedImage.getCompressedData() {
//                DAOImageService.createImage(dayDate: date, time: Date().time, imageData: imageData)
//                update()
//            }
//            picker.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    // MARK: - UINavigationControllerDelegate
//    extension DayRecordsListViewController: UINavigationControllerDelegate { }
