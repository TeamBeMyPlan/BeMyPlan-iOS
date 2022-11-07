//
//  TravelSpotDetailVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit
import Moya
import PanModal
import AVFoundation
import SkeletonView
import RxCocoa
import RxSwift

enum TravelSpotDetailType{
  case recently
  case bemyPlanRecommend
  case nickname
  case travelspot
}

class TravelSpotDetailVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private var planDataList: [HomeListDataGettable.Item] = []
  private let networkService = BaseService.default
  
  var viewType: TravelSpotDetailType = .travelspot
  var sortCase : FilterSortCase = .recently
  var lastPlanId: Int?
  var userData: UserDataRequestDTO?
  var travelSpot: TravelSpotList?
  
  // MARK: - UI Component Part
  @IBOutlet private var contentTableView: UITableView!
  @IBOutlet private var headerLabel: UILabel!
  
  @IBOutlet private var filterButton: UIButton!
  @IBOutlet private var filterImageView: UIImageView!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setUIs()
    setTableViewDelegate()
    regiterCells()
    fetchPlanListData()
    initRefresh()
    setHeaderLabel()
    setFilterButtonState()
  }
  
}

extension TravelSpotDetailVC {
  
  private func writeLogData() {
    if viewType == .recently {
      AppLog.log(at: FirebaseAnalyticsProvider.self, .view_plan_latest)
    } else if viewType == .bemyPlanRecommend {
      AppLog.log(at: FirebaseAnalyticsProvider.self, .view_plan_recommand)
    } else if viewType == .travelspot {
      AppLog.log(at: FirebaseAnalyticsProvider.self, .view_plan_list)
    }
  }
  
  private func setTableViewDelegate() {
    contentTableView.delegate = self
    contentTableView.dataSource = self
    contentTableView.isSkeletonable = true
  }
  
  private func regiterCells() {
    TravelSpotDetailTVC.register(target: contentTableView)
  }
  
  private func setUIs() {
    contentTableView.separatorStyle = .none
  }
    
  // MARK: - IBAction Part
  @IBAction func backBtn(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func filterBtn(_ sender: Any) {
    let filterVC = UIStoryboard(name: "TravelSpot", bundle: nil).instantiateViewController(withIdentifier: TravelSpotFilterVC.className) as! TravelSpotFilterVC
    filterVC.filterStatus = self.sortCase
    filterVC.filterClicked = { [weak self] filter in
      self?.sortCase = filter
      self?.lastPlanId = nil
      UIView.animate(withDuration: 0.5, delay: 0) {
        self?.contentTableView.alpha = 0
        self?.contentTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
      } completion: { _ in
        self?.planDataList.removeAll()
        self?.fetchPlanListData()
        UIView.animate(withDuration: 0.5, delay: 0.25) {
          self?.contentTableView.alpha = 1
        }
      }

    }

    
    presentPanModal(filterVC)
  }
  
  // MARK: - Custom Method Part
  
  private func setHeaderLabel() {
    switch (viewType) {
      case .recently:
        self.headerLabel.text = I18N.PlanList.recentlyHeader
      case .bemyPlanRecommend:
        self.headerLabel.text = I18N.PlanList.bemyPlanRecommendHeader
      case .nickname:
        if let userData = userData {
          self.headerLabel.text = userData.name
        }
      case .travelspot:
        if let travelSpot = travelSpot {
          self.headerLabel.text = travelSpot.getKoreanName()
        }
    }
  }
  
  private func setFilterButtonState() {
    switch(viewType) {
      case .recently,.bemyPlanRecommend:
        filterButton.isEnabled = false
        filterImageView.isHidden = true
        
      case .nickname,.travelspot:
        filterButton.isEnabled = true
        filterImageView.isHidden = false
    }
  }
  
  private func initRefresh() {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(updateUI), for: .valueChanged)
    refresh.attributedTitle = NSAttributedString(string: "")
    contentTableView.refreshControl = refresh
  }
  
  // MARK: - @objc Function Part
  @objc func updateUI(refresh: UIRefreshControl) {
    print("UPDATEUI")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      self.planDataList.removeAll()
      self.lastPlanId = nil
      self.fetchPlanListData()
      refresh.endRefreshing()
    }
  }
  
}
// MARK: - Fetching Data Parts

extension TravelSpotDetailVC {
  
  private func fetchPlanListData() {
    guard lastPlanId != -1 else { return }
    switch(viewType) {
      case .recently: getRecentlyList()
      case .bemyPlanRecommend: getBemyPlanRecommendList()
      case .travelspot: getTravelSpotPlanList()
      case .nickname: getUserPlanList()
    }
  }
  
  private func getRecentlyList() {
    networkService.getRecentlyListWithPagination(lastId: lastPlanId) { result in
      result.success { [weak self] entity in
        guard let entity = entity else { return }
        self?.presentDataToTableView(entity)
      }.catch { err in
        self.postObserverAction(.showNetworkError)
      }
      
    }
  }
  
  private func getBemyPlanRecommendList() {
    networkService.getBemyPlanListWithPagination(lastId: lastPlanId) { result in
      result.success { [weak self] entity in
        guard let entity = entity else { return }
        self?.presentDataToTableView(entity)
      }.catch { err in
        print("GET RECENTLY LIST ERR")
        self.postObserverAction(.showNetworkError)
      }
    }
  }
  
  private func getTravelSpotPlanList() {
    networkService.getRecentlyListWithPagination(lastId: lastPlanId) { result in
      result.success { [weak self] entity in
        guard let entity = entity else { return }
        self?.presentDataToTableView(entity)
      }.catch { err in
        self.postObserverAction(.showNetworkError)
      }
    }
  }
  
  private func getUserPlanList() {
    networkService.getRecentlyListWithPagination(lastId: lastPlanId) { result in
      result.success { [weak self] entity in
        guard let entity = entity else { return }
        self?.presentDataToTableView(entity)
      }.catch { err in
        self.postObserverAction(.showNetworkError)
      }
    }
  }
  
  private func presentDataToTableView(_ entity: HomeListDataGettable) {
    addPlanData(entity.contents)
    contentTableView.reloadData()
  }
  
  private func addPlanData(_ contents: [HomeListDataGettable.Item]) {
    guard contents.count > 0 else { return }
    let firstItem = contents.first!
    
    if !planDataList.contains(where: { item in
      item.planID == firstItem.planID
    }) {
      planDataList += contents
    }
  
  }
}

// MARK: - Extension Part
extension TravelSpotDetailVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return planDataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelSpotDetailTVC.className) as? TravelSpotDetailTVC else {
      return UITableViewCell() }
    cell.selectionStyle = .none
    cell.contentImage.kf.cancelDownloadTask()
    cell.contentImage.image = nil
    cell.setData(data: planDataList[indexPath.row])
    return cell
  }
}

extension TravelSpotDetailVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTravelPlan(source: .planListView,
    //                                                                    postIdx:  String(planDataList[indexPath.row].id)))
    let stateModel = PlanPreviewStateModel(scrapState: planDataList[indexPath.row].scrapStatus,
                                           planId: planDataList[indexPath.row].planID,
                                           isPurchased: planDataList[indexPath.row].orderStatus)
    postObserverAction(.movePlanPreview,object: stateModel)
  }
}

extension TravelSpotDetailVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = screenWidth * (327/375)
    return CGSize(width: cellWidth, height: cellWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 38
  }
}

extension TravelSpotDetailVC {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let height = scrollView.frame.size.height
    let contentYoffset = scrollView.contentOffset.y
    let distanceFromBottom = scrollView.contentSize.height - contentYoffset
    if distanceFromBottom < height {
      // TODO: - 현재 페이징 기능 비활성화 상태
//      fetchPlanListData()
    }
  }
}
