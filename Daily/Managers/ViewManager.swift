import Foundation
import UIKit

class ViewManager {
    
    static func openDayRateView(from parent: UIViewController) {
        let dayRateVC = ViewManager.getVC(storyboardName: "Tools", controllerId: "dayRater")
        parent.navigationController?.pushViewController(dayRateVC, animated: true)
        
        
    }
    
    static func getVC(storyboardName: String, controllerId: String) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: controllerId)
    }
    
}
