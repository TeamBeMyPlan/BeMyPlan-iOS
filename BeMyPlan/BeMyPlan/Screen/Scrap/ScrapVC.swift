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
  private var isInitial = true
  var scrapDataList: [PlanDataGettable] = []
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
  
  override func viewDidAppear(_ animated: Bool) {
    self.isInitial = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchScrapListData(sort: .recently)
  }

  private func setUI(){
    scrapEmptyView.isHidden = true
  }
    
  private func fetchScrapListData(lastId: Int? = nil,sort: FilterSortCase) {
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
    addObserverAction(.changeCurrentTab) { [weak self] noti in
      if let index = noti.object as? TabList {

        if index == .scrap  && self?.isInitial == false {
          self?.fetchScrapListData(sort: .recently)
        }
      }
    }

  }
}
