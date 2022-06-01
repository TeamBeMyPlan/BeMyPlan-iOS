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
  var sortCase : FilterSortCase = .recently
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
//    fetchScrapListData()
    setUI()
    bottomSheetNotification()
  }
  
  private func setUI(){
    scrapEmptyView.alpha = 0
  }
    
  private func fetchScrapListData(lastId: Int? = nil) {
    
                                      
    BaseService.default.getScrapList(lastId: lastId, sort: .recently) { result in
      result.success { entity in
        guard let entity = entity else {return}
        
        self.scrapEmptyView.isHidden = !entity.contents.isEmpty
        self.scrapView.isHidden = entity.contents.isEmpty
        
        scrapView.scrapDataList = entity.contents
        

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
