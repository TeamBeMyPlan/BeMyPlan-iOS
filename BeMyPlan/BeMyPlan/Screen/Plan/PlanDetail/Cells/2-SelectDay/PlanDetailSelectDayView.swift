//
//  PlanDetailSelectDayView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/13.
//

import UIKit

protocol PlanDetailDayDelegate{
  func dayClicked(day : Int)
}

class PlanDetailSelectDayView: XibView{

  static var isFromNib: Bool = true
  var delegate :PlanDetailDayDelegate?
  
  public var totalDay : Int = 4
  var currentDay : Int = 1{
    didSet{
      dayContainerCV.reloadData()
      delegate?.dayClicked(day: currentDay)
    }
  }
  
  @IBOutlet var foldIconImage: UIImageView!
  @IBOutlet var dayContainerCV: UICollectionView!{
    didSet{
      dayContainerCV.delegate = self
      dayContainerCV.dataSource = self
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    registerCells()
    addObserver()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    registerCells()
    addObserver()
  }
  
  @IBAction func foldButtonClicked(_ sender: Any) {
    NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "planDetailButtonClicked"), object: nil)
  }
  
  func setFoldImage(isFolded: Bool){
    if isFolded{
      foldIconImage.image = ImageLiterals.PlanDetail.unfoldDetailIocn
    }else{
      foldIconImage.image = ImageLiterals.PlanDetail.foldDetailIcon
    }
  }
  private func registerCells(){
    PlanDetailDayCVC.register(target: dayContainerCV)
  }
  
  private func addObserver(){

    addObserverAction(keyName: NSNotification.Name.init(rawValue: "detailFoldComplete")) { noti in
      if let result = noti.object as? Bool{
        self.setFoldImage(isFolded: result)
      }
    }
  }
}

extension PlanDetailSelectDayView : UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    makeVibrate()
    currentDay = indexPath.row + 1
  }
}

extension PlanDetailSelectDayView : UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return totalDay
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanDetailDayCVC.className, for: indexPath) as? PlanDetailDayCVC else { return UICollectionViewCell() }
    dayCell.setDayState(isClicked:currentDay == (indexPath.row + 1),
                        day: indexPath.row + 1)
    
    dayCell.layer.cornerRadius = 5
    
    return dayCell
  }
}

extension PlanDetailSelectDayView : UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: 63, height: 37)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
  }
}
