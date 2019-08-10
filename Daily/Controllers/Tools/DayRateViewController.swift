import UIKit

class DayRateViewController: UITableViewController {

    var dayDate: Date?
    
    // MARK: -
    
    @IBOutlet weak var noRateImage: UIImageView!
    @IBOutlet weak var badMoodImage: UIImageView!
    @IBOutlet weak var averageMood: UIImageView!
    @IBOutlet weak var goodMoodImage: UIImageView!
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewSettings()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            rateDay(0.0)
        case 1:
            rateDay(1.0)
        case 2:
             rateDay(2.0)
        case 3:
             rateDay(3.0)
        default:
            break
        }
        
        goBack()
    }
    
    // MARK: -
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setViewSettings() {
        tableView.tableFooterView = UIView()
        
        noRateImage.tintImage(to: DayRateManager.getRateColor(0.0))
        badMoodImage.tintImage(to: DayRateManager.getRateColor(1.0))
        averageMood.tintImage(to: DayRateManager.getRateColor(2.0))
        goodMoodImage.tintImage(to: DayRateManager.getRateColor(3.0))
    }
    
    private func rateDay(_ rate: Double) {
        Day.setDayRate(dayDate: dayDate ?? Date().getStartDay() , rate: rate)
    }

}
