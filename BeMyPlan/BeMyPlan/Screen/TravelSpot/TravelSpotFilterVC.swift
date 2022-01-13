//
//  TravelSpotFilterVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/10.
//

import UIKit
import PanModal

class TravelSpotFilterVC: UIViewController {
  // MARK: - Vars & Lets Part
  
  // MARK: - UI Component Part
  @IBOutlet var filterView: UIView!
  @IBOutlet var filterHandleView: UIView!
  @IBOutlet var recentCheckImg: UIButton!
  @IBOutlet var recentBtn: UIButton!
  @IBOutlet var manyBuyCheckImg: UIButton!
  @IBOutlet var mayBuyBtn: UIButton!
  @IBOutlet var manyScrapImg: UIButton!
  @IBOutlet var mayScrapBtn: UIButton!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIs()
  }
  
  // MARK: - Set Function Part
  private func setUIs() {
    view.clipsToBounds = true
    filterHandleView.layer.cornerRadius = 2
    filterView.layer.cornerRadius = 5

    manyBuyCheckImg.isHidden = true
    manyScrapImg.isHidden = true
    
    recentBtn.setTitleColor(.bemyBlue, for: .normal)
    mayBuyBtn.setTitleColor(.grey02, for: .normal)
    mayScrapBtn.setTitleColor(.grey02, for: .normal)
  }

  
  // MARK: - IBAction Part
  @IBAction func recentBtn(_ sender: Any) {
    recentCheckImg.isHidden = false
    recentBtn.setTitleColor(.bemyBlue, for: .normal)
    manyBuyCheckImg.isHidden = true
    mayBuyBtn.setTitleColor(.grey02, for: .normal)
    manyScrapImg.isHidden = true
    mayScrapBtn.setTitleColor(.grey02, for: .normal)
  }
  
  @IBAction func manyBuyBtn(_ sender: Any) {
    recentCheckImg.isHidden = true
    recentBtn.setTitleColor(.grey02, for: .normal)
    manyBuyCheckImg.isHidden = false
    mayBuyBtn.setTitleColor(.bemyBlue, for: .normal)
    manyScrapImg.isHidden = true
    mayScrapBtn.setTitleColor(.grey02, for: .normal)
  }
  
  @IBAction func manyScrapBtn(_ sender: Any) {
    recentCheckImg.isHidden = true
    recentBtn.setTitleColor(.grey02, for: .normal)
    manyBuyCheckImg.isHidden = true
    mayBuyBtn.setTitleColor(.grey02, for: .normal)
    manyScrapImg.isHidden = false
    mayScrapBtn.setTitleColor(.bemyBlue, for: .normal)
  }
  
  // MARK: - Custom Method Part
  
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








/*
 class TravelSpotVC: UIViewController {
 
 // MARK: - Vars & Lets Part
 
 // MARK: - UI Component Part
 
 // MARK: - Life Cycle Part
 override func viewDidLoad() {
 super.viewDidLoad()
 }
  
 // MARK: - IBAction Part
 
 // MARK: - Custom Method Part
 
 // MARK: - @objc Function Part
 }
 
 // MARK: - Extension Part
 */
