//
//  PlanDetailSelectDayTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

protocol PlanDetailDayDelegate{
  func dayClicked(day : Int)
}

class PlanDetailSelectDayTVC: UITableViewCell,UITableViewRegisterable{

  static var isFromNib: Bool = true
  var delegate : PlanDetailDayDelegate?
  
  public var totalDay : Int = 4{
    didSet{
      dayContainerCV.reloadData()
    }
  }
  public var currentDay : Int = 1{
    didSet{
      dayContainerCV.reloadData()
      delegate?.dayClicked(day: currentDay)
    }
  }
  
  @IBOutlet var dayContainerCV: UICollectionView!{
    didSet{
      dayContainerCV.delegate = self
      dayContainerCV.dataSource = self
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    registerCells()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func registerCells(){
    PlanDetailDayCVC.register(target: dayContainerCV)
  }
}

extension PlanDetailSelectDayTVC : UICollectionViewDelegate{
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    makeVibrate()
    currentDay = indexPath.row + 1
  }
}

extension PlanDetailSelectDayTVC : UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return totalDay
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let dayCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanDetailDayCVC.className, for: indexPath) as? PlanDetailDayCVC else { return UICollectionViewCell() }
    dayCell.setDayState(isClicked:currentDay == (indexPath.row + 1),
                        day: indexPath.row + 1)
    
    return dayCell
  }
}

extension PlanDetailSelectDayTVC : UICollectionViewDelegateFlowLayout{
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
