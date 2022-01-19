//
//  PlanDetailSummaryRouteTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailSummaryRouteTVC: UITableViewCell,UITableViewRegisterable {
  
  static var isFromNib: Bool = true
  let shapeLayer = CAShapeLayer()
  
  @IBOutlet var locationNameLabel: UILabel!
  @IBOutlet var transportIconView: UIImageView!
  @IBOutlet var transportTimeLabel: UILabel!
  @IBOutlet var dotIconView: UIImageView!
  @IBOutlet var dotTopConstraint: NSLayoutConstraint!
  // middle 6, top 26, final
  
  override func awakeFromNib() {
    super.awakeFromNib()
    removeDashedLine()
//    self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    clipsToBounds = true
//    self.contentView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//    self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
  func setLocationData(order :OrderCase,
                       locationName : String,
                       transportCase : TransportCase?,
                       time : String?){
    switch(transportCase){
      case .walk:
        transportIconView.image = ImageLiterals.PlanDetail.walkIcon
      case .bus:
        transportIconView.image = ImageLiterals.PlanDetail.busIcon
      case .car:
        transportIconView.image = ImageLiterals.PlanDetail.carIcon
      case .none:
        transportIconView.image = UIImage()
    }
    if let timeData = time{
      transportTimeLabel.text = timeData
    }else{
      transportTimeLabel.text = ""
    }
    locationNameLabel.text = locationName
    
    switch(order){
      case .first:
        dotTopConstraint.constant = 26
      case .middle:
        dotTopConstraint.constant = 6
      case .final:
        dotTopConstraint.constant = 6
      case .onlyOne :
        dotTopConstraint.constant = 26
    }
    self.contentView.layoutIfNeeded()
    drawLine(order: order)
    layoutIfNeeded()
  }
  
  private func drawLine(order : OrderCase){
    var startPoint :CGPoint
    var endPoint :CGPoint
    switch(order){
      case .first:
        startPoint = CGPoint(x: dotIconView.frame.midX,
                             y: dotIconView.frame.midY)
        endPoint = CGPoint(x: dotIconView.frame.midX,
                           y: dotIconView.frame.midY + 60)
        
      case .middle:
        startPoint = CGPoint(x: dotIconView.frame.midX,
                             y: dotIconView.frame.midY - 16)
        endPoint = CGPoint(x: dotIconView.frame.midX,
                           y: dotIconView.frame.midY + 55)
        
      case .final:
        startPoint = CGPoint(x: dotIconView.frame.midX,
                             y: dotIconView.frame.midY - 10)
        endPoint = CGPoint(x: dotIconView.frame.midX,
                           y: dotIconView.frame.midY)
      default :
        startPoint = CGPoint.zero
        endPoint = CGPoint.zero
        
    }
    print("dotPoint",startPoint,endPoint)
    
    makeDashedLine(from: startPoint,
                                 to: endPoint,
                                 color: .bemyBlue,
                                 strokeLength: 2,
                                 gapLength: 2,
                                 width: 1)
  }
  
  func makeDashedLine(from point1: CGPoint, to point2: CGPoint, color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {


      shapeLayer.strokeColor = color.cgColor
      shapeLayer.lineWidth = width
      shapeLayer.lineDashPattern = [strokeLength, gapLength]
      let path = CGMutablePath()
      path.addLines(between: [point1, point2])
      shapeLayer.path = path
      layer.addSublayer(shapeLayer)
  }
  
  func removeDashedLine(){
    shapeLayer.removeFromSuperlayer()
  }
    
}

enum TransportCase : String{
  case walk = "도보"
  case bus = "버스"
  case car = "택시"
}

enum OrderCase{
  case first
  case middle
  case final
  case onlyOne
}
