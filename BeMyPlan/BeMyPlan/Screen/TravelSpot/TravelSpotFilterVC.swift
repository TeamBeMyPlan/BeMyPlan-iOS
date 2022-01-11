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
  var bottomValue:Float = 1
  
  // MARK: - UI Component Part
//  @IBOutlet var backGroundView: UIView!
  @IBOutlet var filterView: UIView!
  @IBOutlet var filterHandleView: UIView!
  @IBOutlet var recentCheckImg: UIButton!
  @IBOutlet var manyBuyCheckImg: UIButton!
  @IBOutlet var manyScrapImg: UIButton!
  
  @IBOutlet var filterViewBottomConstraints: NSLayoutConstraint!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIs()
    // setPanGesture()
  }
  
  // MARK: - Set Function Part
  
  //  func setAlpha() {
  //    UIView.animate(withDuration: 0.5, animations: {
  //        self.alpha = 0
  //    })
  //  }
  // MARK
  
  // MARK: - IBAction Part
  @IBAction func recentBtn(_ sender: Any) {
    recentCheckImg.isHidden = false
    manyBuyCheckImg.isHidden = true
    manyScrapImg.isHidden = true
  }
  
  @IBAction func manyBuyBtn(_ sender: Any) {
    recentCheckImg.isHidden = true
    manyBuyCheckImg.isHidden = false
    manyScrapImg.isHidden = true
  }
  
  @IBAction func manyScrapBtn(_ sender: Any) {
    recentCheckImg.isHidden = true
    manyBuyCheckImg.isHidden = true
    manyScrapImg.isHidden = false
  }
  
  // MARK: - Custom Method Part
  private func setUIs() {
//    backGroundView.alpha = 0.5
    filterHandleView.layer.cornerRadius = 2
    filterView.layer.cornerRadius = 5
//    filterView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

    //    filterView.layer.masksToBounds = true
    //    UIView.animate(withDuration: 0.5, animations: {
    //      self.backGroundView.alpha = 1
    //    })
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
    return .contentHeight(278)
  }

  
  var longFormHeight: PanModalHeight {
    return .maxHeightWithTopInset(278)
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
 
 // MARK: - Set Function Part
 
 // MARK: - IBAction Part
 
 // MARK: - Custom Method Part
 
 // MARK: - @objc Function Part
 }
 
 // MARK: - Extension Part
 */
