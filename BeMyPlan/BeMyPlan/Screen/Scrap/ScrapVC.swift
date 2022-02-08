//
//  ScrabVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/07.
//

import UIKit
import PanModal
import Moya

class ScrapVC: UIViewController {
    
  @IBOutlet var scrapView: ScrapContainerView!
  @IBOutlet var scrapEmptyView: ScrapEmptyContainerView!
  
  // MARK: - Vars & Lets Part
  var scrapDataList:[ScrapDataGettable] = []
  var sortCase : SortCase = .recently
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchScrapListData()
    bottomSheetNotification()
  }
    
  private func fetchScrapListData() {
    BaseService.default.getScrapList(page: 0, pageSize: 5, sort: "created_at") { result in
      result.success { data in
        if let testedData = data {
          if testedData.items.count == 0 {
            self.scrapView.isHidden = true
          } else {
            self.scrapEmptyView.isHidden = true
          }
        }
      }
    }
  }
  
  private func bottomSheetNotification() {
    addObserverAction(.filterBottomSheet) { _ in
      let vc = UIStoryboard(name: "TravelSpot", bundle: nil).instantiateViewController(withIdentifier: "TravelSpotFilterVC") as! TravelSpotFilterVC
      vc.filterStatus = self.sortCase
      vc.filterClicked = { filter in self.sortCase = filter }
      self.presentPanModal(vc)
    }
  }
}
