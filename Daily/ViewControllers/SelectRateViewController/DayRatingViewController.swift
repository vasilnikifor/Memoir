import UIKit

protocol SelectRateDelegate {
    func rateDidChange()
}

final class DayRatingViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private var date: Date = Date()
    private var dayRate: DayRate = .noRate
    private var delegate: SelectRateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DayRateTableViewCell.nib, forCellReuseIdentifier: DayRateTableViewCell.nibName)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = Localized.dayRating
    }

    func configure(date: Date, delegate: SelectRateDelegate?) {
        self.date = date
        self.delegate = delegate
        
        if let day = DAODayService.getDay(date: date) {
            dayRate = day.rate
        }
    }
}

// MARK: - UITableViewDelegate
extension DayRatingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DAODayService.setDayRate(dayDate: date.startOfDay, rate: DayRate.allCases[indexPath.row])
        delegate?.rateDidChange()
        dismiss()
    }
}

// MARK: - UITableViewDataSource
extension DayRatingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DayRate.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayRateTableViewCell.nibName, for: indexPath) as! DayRateTableViewCell
        let dayRate = DayRate.allCases[indexPath.row]
        cell.configure(DayRateTableVievCellViewModel(dayRate: dayRate, isSelected: self.dayRate == dayRate))
        return cell
    }
}
