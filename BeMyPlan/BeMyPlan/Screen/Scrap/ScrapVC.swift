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
  var scrapDataList: [ScrapDataGettable] = []
  var sortCase: FilterSortCase = .recently
  var nextCursor: Int = 0
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    registerObserverActions()
    bottomSheetNotification()
    fetchRecomendData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchScrapListData(sort: .recently)
  }

  private func setUI(){
    scrapEmptyView.isHidden = true
  }
    
  private func fetchScrapListData(lastId: Int? = nil,sort: FilterSortCase) {
    guard nextCursor != -1 else { return }
    var sortCase: FilterSortCase
    if sort == .scrapCount { sortCase = .orderCount }
    else { sortCase = sort }
    BaseService.default.getScrapList(lastId: lastId, sort: sortCase) { result in
      result.success { entity in
        guard let entity = entity else {return}
        self.scrapEmptyView.isHidden = !entity.contents.isEmpty
        self.scrapView.isHidden = entity.contents.isEmpty
        self.nextCursor = entity.nextCursor

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
      vc.filterClicked = { filter in
        self.sortCase = filter
        self.fetchScrapListData(sort: filter)
      }
      self.presentPanModal(vc)
    }
  }
  
  private func registerObserverActions() {
    addObserverAction(.moveHomeTab) { [weak self] _ in
      self?.fetchScrapListData(sort: .recently)
    }
    
    addObserverAction(.moveTravelSpotTab) { [weak self] _ in
      self?.fetchScrapListData(sort: .recently)
    }
    
    addObserverAction(.moveMyPlanTab) { [weak self] _ in
      self?.fetchScrapListData(sort: .recently)
    }
  }

  
  
}
