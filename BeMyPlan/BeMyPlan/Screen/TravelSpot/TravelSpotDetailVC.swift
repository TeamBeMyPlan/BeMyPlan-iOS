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

class TravelSpotDetailVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private var travelSpotDetailDataList: [TravelSpotDetailData] = []
  private var areaNum: Int = 2
  private var pageNum: Int = 0
  private var totalPage: Int = 0

  
  // MARK: - UI Component Part
  @IBOutlet var contentTableView: UITableView!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    getAreaData()
    regiterXib()
    setTableViewDelegate()
    fetchTravelSpotDetailItemList(refresh: false)
    setUIs()
    initRefresh()
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
    let vc = UIStoryboard(name: "TravelSpot", bundle: nil).instantiateViewController(withIdentifier: TravelSpotVC.className) as! TravelSpotFilterVC
    presentPanModal(vc)
  }
  
  // MARK: - Custom Method Part
  private func setUIs() {
    contentTableView.separatorStyle = .none
  }
  
  private func fetchTravelSpotDetailItemList(refresh: Bool) {
    BaseService.default.getTravelSpotDetailList(area: areaNum, page: pageNum, sort: "created_at") { result in
      result.success { data in
        if let testedData = data {
          if refresh == false {
            self.totalPage = testedData.totalPage - 1
            self.travelSpotDetailDataList.append(testedData.items[0])
          } else {
            self.travelSpotDetailDataList = testedData.items
          }
        }
        self.contentTableView.reloadData()
      }.catch { error in
        if let err = error as? MoyaError {
          dump("----> TravelSpotDetail \(err)")
        }
      }
    }
  }
  
  private func initRefresh() {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
    refresh.attributedTitle = NSAttributedString(string: "")
    
    if #available(iOS 10.0, *) {
      contentTableView.refreshControl = refresh
    } else {
      contentTableView.addSubview(refresh)
    }
  }
  
  
  // MARK: - @objc Function Part
  @objc func updateUI(refresh: UIRefreshControl) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
      self.fetchTravelSpotDetailItemList(refresh: true)
      self.contentTableView.reloadData()
      refresh.endRefreshing() // 리프레쉬 종료
    }
  }
  
}

// MARK: - Extension Part
extension TravelSpotDetailVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return travelSpotDetailDataList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelSpotDetailTVC.identifier) as? TravelSpotDetailTVC else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    cell.nickNameLabel.text = "\(travelSpotDetailDataList[indexPath.row].id)"
    cell.titleTextView.text = "\(travelSpotDetailDataList[indexPath.row].title)"
    cell.contentImage.setImage(with: "\(travelSpotDetailDataList[indexPath.row].thumbnailURL)")
    
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


extension TravelSpotDetailVC {
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let height = scrollView.frame.size.height
    let contentYoffset = scrollView.contentOffset.y
    let distanceFromBottom = scrollView.contentSize.height - contentYoffset
    if distanceFromBottom < height {
      if pageNum < totalPage {
        pageNum += 1
        fetchTravelSpotDetailItemList(refresh: false)
      }
    }
  }
}
