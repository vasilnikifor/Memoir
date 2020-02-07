import UIKit

protocol DayRecordsListDelegat {
    func update()
}

final class DayRecordsListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
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
    
    func configure(listDate: Date) {
        date = listDate
        
        update()
    }
}

extension DayRecordsListViewController: DayRecordsListDelegat {
    func update() {
        let day = Day.getDay(date: date)
        
//        let rateButtonItem = UIBarButtonItem(image: Theme.getRateImage(day?.rate),style: .plain,target: nil,action: nil)
//        rateButtonItem.tintColor = Theme.getRateColor(day?.rate)
//        navigationItem.rightBarButtonItem = rateButtonItem
//        navigationItem.title = date.dateRepresentation
        
        if let dayRecords = day?.records?.sortedArray(using: [NSSortDescriptor(key: "time", ascending: true)]) as? [Record] {
            records = dayRecords
        } else {
            records = []
        }
        
        if let rate = day?.rate, rate != .noRate {
            let imageView = UIImageView(image: Theme.getRateImage(rate))
            imageView.tintColor = Theme.getRateColor(rate)
            
            let titleView = NavigationTitleView()
            titleView.configure(title: date.dateRepresentation, imageView: imageView)
            
            navigationItem.titleView = titleView
        } else {
            let titleView = NavigationTitleView()
            titleView.configure(title: date.dateRepresentation)
            
            navigationItem.titleView = titleView
        }
        
        tableView.reloadData()
    }
}

extension DayRecordsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let record = records[indexPath.row] as? NoteRecord {
            print(record)
        } else if let record = records[indexPath.row] as? ImageRecord {
            print(record)
        }
    }
}

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
