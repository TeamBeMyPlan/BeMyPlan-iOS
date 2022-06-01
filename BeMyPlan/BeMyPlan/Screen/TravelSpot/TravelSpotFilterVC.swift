//
//  TravelSpotFilterVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/10.
//

/// dismiss 자동으로 처리
///

import UIKit
import PanModal

class TravelSpotFilterVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  public var filterClicked: ((FilterSortCase) -> ())?
  public var filterStatus: FilterSortCase = .recently
  
  // MARK: - UI Component Part
  @IBOutlet var filterView: UIView!
  @IBOutlet var filterHandleView: UIView!
  @IBOutlet var recentCheckImg: UIButton!
  @IBOutlet var recentBtn: UIButton!
  @IBOutlet var orderCheckImg: UIButton!
  @IBOutlet var orderBtn: UIButton!
  @IBOutlet var scrapCheckImg: UIButton!
  @IBOutlet var scrapBtn: UIButton!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIs()
    setCheckButton()
    setTitleColor()
  }
  
  // MARK: - Set Function Part
  private func setUIs() {
    view.clipsToBounds = true
    filterHandleView.layer.cornerRadius = 2
    filterView.layer.cornerRadius = 5

    orderCheckImg.isHidden = true
    scrapCheckImg.isHidden = true
    
    recentBtn.setTitleColor(.bemyBlue, for: .normal)
    orderBtn.setTitleColor(.grey02, for: .normal)
    scrapBtn.setTitleColor(.grey02, for: .normal)
  }

  // MARK: - IBAction Part
  
  @IBAction func recentButtonClicked(_ sender: Any) {
    makeVibrate()
    dismiss(animated: true){ self.filterClicked?(.recently) }
  }

  @IBAction func orderButtonCLicked(_ sender: Any) {
    makeVibrate()
    dismiss(animated: true){ self.filterClicked?(.orderCount) }
  }
  @IBAction func scrapButtonClicked(_ sender: Any) {
    makeVibrate()
    dismiss(animated: true){ self.filterClicked?(.scrapCount) }
  }

  
  // MARK: - Custom Method Part
  
  private func setTitleColor(){
    recentBtn.setTitleColor(.grey02, for: .normal)
    orderBtn.setTitleColor(.grey02, for: .normal)
    scrapBtn.setTitleColor(.grey02, for: .normal)

    switch(filterStatus){
      case .recently: recentBtn.setTitleColor(.bemyBlue, for: .normal)
      case .orderCount: orderBtn.setTitleColor(.bemyBlue, for: .normal)
      case .scrapCount: scrapBtn.setTitleColor(.bemyBlue, for: .normal)
    }
  }
  
  private func setCheckButton(){
    recentCheckImg.isHidden = true
    orderCheckImg.isHidden = true
    scrapCheckImg.isHidden = true
    switch(filterStatus){
      case .recently: recentCheckImg.isHidden = false
      case .orderCount: orderCheckImg.isHidden = false
      case .scrapCount: scrapCheckImg.isHidden = false
    }
  }
  
  // MARK: - @objc Function Part
  
}

// MARK: - Extension Part
extension TravelSpotFilterVC: PanModalPresentable {
  
  var panScrollable: UIScrollView? {
    return nil
  }

  // 처음 시작 위치
  var shortFormHeight: PanModalHeight {
    return .contentHeightIgnoringSafeArea(278)
  }

  var longFormHeight: PanModalHeight {
    return .contentHeightIgnoringSafeArea(278)
  }

  var dragIndicatorBackgroundColor: UIColor {
    return .clear
  }

}
