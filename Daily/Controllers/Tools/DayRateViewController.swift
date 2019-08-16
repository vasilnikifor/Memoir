import UIKit

class DayRateViewController: UITableViewController {

    private let moodCellId = "moodCell"
    
    var dayDate: Date?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewSettings()
    }
    
    // MARK: - Private methods
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setViewSettings() {
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.register(DayRateTableViewCell.self, forCellReuseIdentifier: moodCellId)
        
    }
    
    private func rateDay(_ rate: Double) {
        Day.setDayRate(dayDate: dayDate ?? Date().getStartDay(), rate: rate)
    }

}

// MARK: - UITableViewDelegate protocol implementation
extension DayRateViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DayRate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: moodCellId, for: indexPath) as! DayRateTableViewCell
        
        cell.configure(dayRate: .norm)
        
        return cell
    }
    
}
