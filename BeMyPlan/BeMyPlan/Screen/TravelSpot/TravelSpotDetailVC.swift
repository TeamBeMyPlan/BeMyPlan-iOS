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
  case new
  case suggest
  case nickname
  case travelspot
}

class TravelSpotDetailVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  //  var travelSpotDetailDataList: [TravelSpotDetailData] = []
  var planDataList: [HomeListDataGettable.Item] = []
//  var scrapBtnData: ScrapBtnData =
  var scrapBtnData: Bool = true
  var areaNum: Int?
  var nickname : String?
  var postId: Int = 0
  
  var currentPageIndex = 0
  var areaId: Int? = 2
  var userId: Int?
  var type : TravelSpotDetailType = .travelspot
  var sortCase : SortCase = .recently {
    didSet {
      /// API 호출 함수
      print("#### \(sortCase)")
//      fetchTravelSpotDetailItemList(isRefresh: true)
    }
  }
  
  
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
    getAreaData()
    regiterXib()
    setTableViewDelegate()
    setUIs()
    fetchTravelSpotDetailItemList(isRefresh: true)
    initRefresh()
    setHeaderLabel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchTravelSpotDetailItemList(isRefresh: true)
  }
  
  // MARK: - Set Function Part
  private func getAreaData() {
    guard let vc = storyboard?.instantiateViewController(identifier: TravelSpotVC.className) as? TravelSpotVC else { return }
    vc.completionHandler = { area in
      self.areaNum = area
      return area
    }
  }
  
  private func setTableViewDelegate() {
    contentTableView.delegate = self
    contentTableView.dataSource = self
  }
  
  private func regiterXib() {
    let xibName = UINib(nibName: TravelSpotDetailTVC.className, bundle: nil)
    contentTableView.register(xibName, forCellReuseIdentifier: TravelSpotDetailTVC.className)
  }
  
  // MARK: - IBAction Part
  @IBAction func backBtn(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func filterBtn(_ sender: Any) {
    let filterVC = UIStoryboard(name: "TravelSpot", bundle: nil).instantiateViewController(withIdentifier: TravelSpotFilterVC.className) as! TravelSpotFilterVC
    
    filterVC.filterClicked = { [weak self] filter in
      self?.sortCase = filter
      filterVC.filterStatus = self!.sortCase
      print("@@@@ \(self?.sortCase)")
    }
//    filterVC.filterStatus = sortCase
//    print("@@@@ \(self.sortCase)")
    presentPanModal(filterVC)
  }

  // MARK: - Custom Method Part
  private func setUIs() {
    contentTableView.separatorStyle = .none
  }
  
  private func setHeaderLabel() {
    switch (type) {
    case .new:
      self.headerLabel.text = "최신 여행 일정"
    case .suggest:
      self.headerLabel.text = "에디터 추천 일정"
    case .nickname:
        if let nickname = nickname {
          self.headerLabel.text = nickname
        }
    case .travelspot:
      self.headerLabel.text = "제주"
      
    }
  }
  
  
  private func fetchTravelSpotDetailItemList(isRefresh: Bool) {
    BaseService.default.getPlanAllinOneList(area: areaId,
                                            userId: userId,
                                            page: currentPageIndex,
                                            sort: sortCase.rawValue,
                                            viewCase: type) { result in
      result.success { [weak self] list in
        if let list = list {
          if list.items.count != 0 {
            if isRefresh == false {
              list.items.forEach { item in
                self?.planDataList.append(item)
              }
              self?.currentPageIndex += 1
            } else {
              self?.planDataList.removeAll()
              self?.planDataList = list.items
              self?.currentPageIndex = 0
            }
            self?.contentTableView.reloadData()
          }
        }
      }.catch{ error in
        print("travelspot err")
        dump(error)
      }
    }
  }
  
  public func scrapBtnAPI() {
//    BaseService.default.postScrapBtnTapped(postId: postId, userId: userId) { result in
    BaseService.default.postScrapBtnTapped(postId: postId) { result in
      result.success { data in
        dump("#### \(data)")
        if let testedData = data {
          print("---> 버튼클릭값 \(testedData)")
          self.scrapBtnData = testedData.scrapped
        }
      }.catch { error in
        dump("!!!! \(error)")
        if let err = error as? MoyaError {
          dump(err)
        }
      }
    }
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

    cell.scrapBtnClicked = { [weak self] post in
      self?.postId = post
      print("@@@@\(self?.postId)")
      self?.scrapBtnAPI()
      print("$$$$$$")

    }

//    if planDataList[indexPath.row].isScraped == true {
//      cell.scrapBtn.setImage(UIImage(named: "icon_scrab"), for: .normal)
//    } else {
//      cell.scrapBtn.setImage(UIImage(named: "icnNotScrapWhite"), for: .normal)
//
//    }

    
    return cell
  }
}

extension TravelSpotDetailVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .movePlanPreview), object: planDataList[indexPath.row].id)
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

enum SortCase: String {
  case recently = "created_at"
  case orderCount = "order_count"
  case price = "price"
}
