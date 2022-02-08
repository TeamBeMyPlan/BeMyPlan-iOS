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
  public var filterClicked: ((SortCase) -> ())?
  public var filterStatus: SortCase = .recently
  
  // MARK: - UI Component Part
  @IBOutlet var filterView: UIView!
  @IBOutlet var filterHandleView: UIView!
  @IBOutlet var recentCheckImg: UIButton!
  @IBOutlet var recentBtn: UIButton!
  @IBOutlet var orderCheckImg: UIButton!
  @IBOutlet var orderBtn: UIButton!
  @IBOutlet var priceScrapImg: UIButton!
  @IBOutlet var priceBtn: UIButton!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIs()
    setButtonStatus()
  }
  
  // MARK: - Set Function Part
  private func setUIs() {
    view.clipsToBounds = true
    filterHandleView.layer.cornerRadius = 2
    filterView.layer.cornerRadius = 5

    orderCheckImg.isHidden = true
    priceScrapImg.isHidden = true
    
    recentBtn.setTitleColor(.bemyBlue, for: .normal)
    orderBtn.setTitleColor(.grey02, for: .normal)
    priceBtn.setTitleColor(.grey02, for: .normal)
  }

  // MARK: - IBAction Part
  
  @IBAction func recentButtonClicked(_ sender: Any) {
    makeVibrate()
    recentlyStandard()
  }

  @IBAction func orderButtonCLicked(_ sender: Any) {
    makeVibrate()
    orderCountStandard()

  }
  @IBAction func scrapButtonClicked(_ sender: Any) {
    makeVibrate()
    priceStandard()
  }

  @IBAction func recentBtn(_ sender: Any) {
  }
  
  @IBAction func orderBtn(_ sender: Any) {
  }
  
  @IBAction func priceBtn(_ sender: Any) {
  }
  
  // MARK: - Custom Method Part
  private func recentlyStandard() {
    recentCheckImg.isHidden = false
    recentBtn.setTitleColor(.bemyBlue, for: .normal)
    orderCheckImg.isHidden = true
    orderBtn.setTitleColor(.grey02, for: .normal)
    priceScrapImg.isHidden = true
    priceBtn.setTitleColor(.grey02, for: .normal)
    
    if let filterClicked = filterClicked {
      filterClicked(.recently)
    }
    dismiss(animated: true, completion: nil)
  }
  
  private func orderCountStandard() {
    recentCheckImg.isHidden = true
    recentBtn.setTitleColor(.grey02, for: .normal)
    orderCheckImg.isHidden = false
    orderBtn.setTitleColor(.bemyBlue, for: .normal)
    priceScrapImg.isHidden = true
    priceBtn.setTitleColor(.grey02, for: .normal)

    if let filterClicked = filterClicked {
      filterClicked(.orderCount)
    }
    dismiss(animated: true, completion: nil)
  }
  
  private func priceStandard() {
    recentCheckImg.isHidden = true
    recentBtn.setTitleColor(.grey02, for: .normal)
    orderCheckImg.isHidden = true
    orderBtn.setTitleColor(.grey02, for: .normal)
    priceScrapImg.isHidden = false
    priceBtn.setTitleColor(.bemyBlue, for: .normal)

    if let filterClicked = filterClicked {
      filterClicked(.price)
    }

    dismiss(animated: true, completion: nil)
  }
  
  private func setButtonStatus() {
    guard filterStatus.rawValue == SortCase.recently.rawValue else {
      recentlyStandard()
      return
    }
    
    guard filterStatus.rawValue == SortCase.orderCount.rawValue else {
      orderCountStandard()
      return
    }
    
    guard filterStatus.rawValue == SortCase.price.rawValue else {
      priceStandard()
      return
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
