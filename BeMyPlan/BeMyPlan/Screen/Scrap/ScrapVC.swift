//
//  ScrabVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/07.
//

import UIKit
import PanModal

class ScrapVC: UIViewController {
    
  @IBOutlet var scrapView: ScrapContainerView!
  @IBOutlet var scrapEmptyView: ScrapEmptyContainerView!
  
  // MARK: - Vars & Lets Part
  let contentData: Bool = false

  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    hiddenContainerView()
    bottomSheetNotification()
  }
  
  // MARK: - IBAction Part
  
  // MARK: - Custom Method Part
  private func hiddenContainerView() {
    if contentData == true {
      scrapEmptyView.isHidden = true
    } else {
      scrapView.isHidden = true
    }
  }
  
  private func bottomSheetNotification() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(bottomSheetAction),
                                           name: NSNotification.Name("filterBottomSheet"),
                                           object: nil)
  }
    
  // MARK: - @objc Function Part
  @objc func bottomSheetAction(_ notification: Notification) {
    let vc = UIStoryboard(name: "TravelSpot", bundle: nil).instantiateViewController(withIdentifier: "TravelSpotFilterVC") as! TravelSpotFilterVC
    presentPanModal(vc)
  }
}

// MARK: - Extension Part

