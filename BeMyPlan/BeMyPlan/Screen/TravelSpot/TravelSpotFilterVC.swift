//
//  TravelSpotFilterVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/10.
//

import UIKit

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
 
  /*
  private func setPanGesture() {
    // UIPanGestureRecognizer는 target(ViewController)에서 drag가 감지되면 action을 실행한다.
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
    // panGesture가 보는 view는 circleView가 된다.
    filterView.addGestureRecognizer(panGesture)
  }
 */
  
  /*
  // MARK: - @objc Function Part
  @objc func drag(sender: UIPanGestureRecognizer) {
    // self는 여기서 ViewController이므로 self.view ViewController가 기존에가지고 있는 view이다.
    let translation = sender.translation(in: self.view) // translation에 움직인 위치를 저장한다.
    
    // sender의 view는 sender가 바라보고 있는 circleView이다. 드래그로 이동한 만큼 circleView를 이동시킨다.

    filterViewBottomConstraints.constant = CGFloat(bottomValue)
    // CGFloat(  // CGFloat(bottomValue)
    bottomValue += 1
  }
  // 뷰를 눌렀을 때 화아아악 하고 투명도가 꽉 채워져야 하는데 그러면 backGroundView가 버튼이어야 하는가?
   */
}
// MARK: - Extension Part










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
