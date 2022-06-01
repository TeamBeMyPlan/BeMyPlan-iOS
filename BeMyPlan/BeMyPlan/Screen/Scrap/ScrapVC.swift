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
    setUI()
    bottomSheetNotification()
    fetchScrapListData(sort: .recently)
    fetchRecomendData()
  }
  
  private func setUI(){
    scrapEmptyView.isHidden = true
  }
    
  private func fetchScrapListData(lastId: Int? = nil,sort: FilterSortCase) {
    BaseService.default.getScrapList(lastId: lastId, sort: sort) { result in
      result.success { entity in
        guard let entity = entity else {return}
        self.scrapEmptyView.isHidden = !entity.contents.isEmpty
        self.scrapView.isHidden = entity.contents.isEmpty

        self.scrapView.scrapDataList = entity.contents
      }.catch { _ in
        self.postObserverAction(.showNetworkError)
      }
    }
  }
  
  private func fetchRecomendData() {
    BaseService.default.getHomeBemyPlanSortList { result in
      result.success { entity in
        guard let entity = entity else { return }
        self.scrapEmptyView.contentDataList = entity.contents
      }.catch { _ in
        self.postObserverAction(.showNetworkError)
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
