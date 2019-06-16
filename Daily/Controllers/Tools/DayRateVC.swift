import UIKit

class DayRateVC: UITableViewController {

    var dayDate: Date?
    
    @IBOutlet weak var noRateImage: UIImageView!
    @IBOutlet weak var badMoodImage: UIImageView!
    @IBOutlet weak var averageMood: UIImageView!
    @IBOutlet weak var goodMoodImage: UIImageView!
    
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
             rateDay(3.0)
        case 3:
             rateDay(5.0)
        default:
            break
        }
        
        goBack()
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setViewSettings() {
        tableView.tableFooterView = UIView()
        
        noRateImage.image   = noRateImage.image?.tintImage(     CalendarDrawer.getRateColor(0.0))
        badMoodImage.image  = badMoodImage.image?.tintImage(    CalendarDrawer.getRateColor(1.0))
        averageMood.image   = averageMood.image?.tintImage(     CalendarDrawer.getRateColor(3.0))
        goodMoodImage.image = goodMoodImage.image?.tintImage(   CalendarDrawer.getRateColor(5.0))
    }
    
    private func rateDay(_ rate: Double) {
        Day.setDayRate(dayDate: dayDate ?? Date().getStartDay() , rate: rate)
    }
    
    

}
