import UIKit

struct CalendarActiveDayViewModel {
    let date: Date
    let dayColor: UIColor
    let isHighlited: Bool
}

class CalendarActiveDayCollectionVIewCell: UICollectionViewCell {
    @IBOutlet private weak var dateLabel: MediumPrimaryTextLabel!
    @IBOutlet private weak var highlightedDateLabel: LargeMediumBoldPrimaryTextLabel!
    @IBOutlet private weak var circleView: UIView!
    
//    private var circle: CAShapeLayer? = nil
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        print(circleView.frame)
//    }

    func configure(_ viewModel: CalendarActiveDayViewModel) {
//        if circle == nil {
//            let edge = min(circleView.frame.width, circleView.frame.height) / 2
//            let circlePath = UIBezierPath(arcCenter: CGPoint(x: edge, y: edge),
//                                          radius: CGFloat(20),
//                                          startAngle: CGFloat(0),
//                                          endAngle: CGFloat(Double.pi * 2),
//                                          clockwise: true)
//
//            circle = CAShapeLayer()
//
//            if let circle = circle {
//                circle.path = circlePath.cgPath
//                circleView.layer.addSublayer(circle)
//            }
//        }
//        circle?.fillColor = viewModel.dayColor.cgColor
        
        circleView.backgroundColor = viewModel.dayColor
        
        if viewModel.isHighlited {
            dateLabel.text = nil
            highlightedDateLabel.text = viewModel.date.dateNumber
        } else {
            dateLabel.text = viewModel.date.dateNumber
            highlightedDateLabel.text = nil
        }
    }
}
