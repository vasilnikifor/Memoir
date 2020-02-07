import UIKit

class DayRateViewController: UITableViewController {

    private let moodCellId = "moodCell"
    
    var dayDate: Date!
    
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
        tableView.register(UINib.init(nibName: "DayRateTableViewCell", bundle: nil), forCellReuseIdentifier: moodCellId) 
        
    }
    
    private func rateDay(_ rate: DayRate) {
        Day.setDayRate(dayDate: dayDate ?? Date().startOfDay, rate: rate)
    }

}

extension DayRateViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DayRate.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: moodCellId, for: indexPath) as! DayRateTableViewCell
        
        let currentDatyRate = Day.getDay(date: dayDate)?.rate ?? DayRate.noRate
        let currentDrovintRate = DayRate.allCases[indexPath.row]
        cell.configure(for: currentDrovintRate, isSelected: currentDrovintRate == currentDatyRate)
        
        return cell
    }
    
}

extension DayRateViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rateDay(DayRate.allCases[indexPath.row])
        goBack()
    }
    
}
