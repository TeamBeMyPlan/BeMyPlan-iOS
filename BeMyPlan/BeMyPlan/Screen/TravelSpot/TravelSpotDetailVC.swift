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

enum TravelSpotDetailType{
  case recently
  case bemyPlanRecommend
  case nickname
  case travelspot
}

class TravelSpotDetailVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  var planDataList: [HomeListDataGettable.Item] = []
  var scrapBtnData: Bool = true
  var areaNum: Int?
  var nickname : String?
  var postId: Int = 0
  
  var currentPageIndex = 0
  var areaId: Int? = 2
  var userId: Int?
  var type : TravelSpotDetailType = .travelspot
  var sortCase : FilterSortCase = .recently
  
  // MARK: - UI Component Part
  @IBOutlet var contentTableView: UITableView!
  @IBOutlet var headerLabel: UILabel!{
    didSet {
      setHeaderLabel()
    }
  }
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setTableViewDelegate()
    regiterCells()
    setUIs()
    fetchTravelSpotDetailItemList(isRefresh: true)
    initRefresh()
    setHeaderLabel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchTravelSpotDetailItemList(isRefresh: true)
  }
}
  

extension TravelSpotDetailVC {
  
  private func setTableViewDelegate() {
    contentTableView.delegate = self
    contentTableView.dataSource = self
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
    }
    presentPanModal(filterVC)
  }

  // MARK: - Custom Method Part

  private func setHeaderLabel() {
    switch (type) {
    case .recently:
      self.headerLabel.text = "최신 여행 일정"
    case .bemyPlanRecommend:
      self.headerLabel.text = "에디터 추천 일정"
    case .nickname:
        if let nickname = nickname { self.headerLabel.text = nickname }
    case .travelspot:
      self.headerLabel.text = "제주"
    }
  }
  
  private func fetchTravelSpotDetailItemList(isRefresh: Bool) {

    
  }

  private func initRefresh() {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
    refresh.attributedTitle = NSAttributedString(string: "")
    contentTableView.refreshControl = refresh
  }
  
  // MARK: - @objc Function Part
  @objc func updateUI(refresh: UIRefreshControl) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      self.currentPageIndex = 0
      self.fetchTravelSpotDetailItemList(isRefresh: true)
      refresh.endRefreshing()
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
      return UITableViewCell()
    }
    cell.selectionStyle = .none
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
//    postObserverAction(.movePlanPreview,object: planDataList[indexPath.row].id)
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
      fetchTravelSpotDetailItemList(isRefresh: false)
    }
  }
}
