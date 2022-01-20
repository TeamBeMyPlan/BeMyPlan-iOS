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
  var areaNum: Int?
  
  var currentPageIndex = 1
  var areaId: Int?
  var userId: Int?
  var type : TravelSpotDetailType = .travelspot
  var sortcase : SortCase = .recently
  
  
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
    initRefresh()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchTravelSpotDetailItemList()
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
    let xibName = UINib(nibName: TravelSpotDetailTVC.identifier, bundle: nil)
    contentTableView.register(xibName, forCellReuseIdentifier: TravelSpotDetailTVC.className)
  }
  
  // MARK: - IBAction Part
  @IBAction func backBtn(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func filterBtn(_ sender: Any) {
    let vc = UIStoryboard(name: "TravelSpot", bundle: nil).instantiateViewController(withIdentifier: TravelSpotFilterVC.className) as! TravelSpotFilterVC
    presentPanModal(vc)
  }
  
  // MARK: - Custom Method Part
  private func setUIs() {
    contentTableView.separatorStyle = .none
  }
  
  private func setHeaderLabel() {
    switch (type){
    case .new:
      self.headerLabel.text = "최신여행일정"
    case .suggest:
      self.headerLabel.text = "에디터추천일정"
    case .nickname:
      self.headerLabel.text = "닉네임"
    case .travelspot:
      self.headerLabel.text = "제주"
      
    }
  }
  
  private func fetchTravelSpotDetailItemList() {
    BaseService.default.getPlanAllinOneList(area: areaId,
                                            userId: userId,
                                            page: currentPageIndex,
                                            sort: "created_at",
                                            viewCase: type) { result in
      result.success { [weak self] list in
        self?.planDataList.removeAll()
        print("TravelSpot 여기여기여기여기여기여기여기여기여기여기여기여기")
        print(list?.items)
        if let list = list {
          self?.planDataList = list.items
        }
        self?.contentTableView.reloadData()
        
      }.catch{ error in
        print("travelspot err")
        dump(error)
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
//      self.fetchTravelSpotDetailItemList(refresh: true)
      self.contentTableView.reloadData()
      refresh.endRefreshing() // 리프레쉬 종료
    }
  }
  
}

// MARK: - Extension Part
extension TravelSpotDetailVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return planDataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelSpotDetailTVC.identifier) as? TravelSpotDetailTVC else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    
    cell.nickNameLabel.text = "\(planDataList[indexPath.row].id)"
    cell.titleTextView.text = "\(planDataList[indexPath.row].title)"
    cell.contentImage.setImage(with: "\(planDataList[indexPath.row].thumbnailURL)")
    
    return cell
  }
}

extension TravelSpotDetailVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .movePlanPreview), object: nil)
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


enum SortCase : String{
  case recently = "created_at"
}


//extension TravelSpotDetailVC {
//
//  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//    let height = scrollView.frame.size.height
//    let contentYoffset = scrollView.contentOffset.y
//    let distanceFromBottom = scrollView.contentSize.height - contentYoffset
//    if distanceFromBottom < height {
//      if pageNum < totalPage {
//        pageNum += 1
//        fetchTravelSpotDetailItemList(refresh: false)
//      }
//    }
//  }
//}
