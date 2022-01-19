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
  var travelSpotDetailDataList: [TravelSpotDetailData] = []
  var areaNum: Int = 2
  
  
  
  
  // MARK: - UI Component Part
  @IBOutlet var contentTableView: UITableView!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    getAreaData()
    regiterXib()
    setTableViewDelegate()
    fetchTravelSpotDetailItemList()
  }
   
  // MARK: - Set Function Part
  
  private func getAreaData() {
    guard let vc = storyboard?.instantiateViewController(identifier: TravelSpotVC.className) as? TravelSpotVC else { return }
    vc.completionHandler = { area in
      self.areaNum = area
      print("---> 넘넘넘넘 \(self.areaNum)")
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
  
  }
  
  private func fetchTravelSpotDetailItemList() {
    BaseService.default.getTravelSpotDetailList(area: areaNum, page: 0, sort: "created_at") { result in
      print("---> area \(self.areaNum)")
      dump("---> 리절트 \(result)")

      result.success { data in
        self.travelSpotDetailDataList = []

        if let testedData = data {
          self.travelSpotDetailDataList = testedData.items
          dump("---> testedData \(String(describing: testedData))")
        }
        self.contentTableView.reloadData()
      }.catch { error in
        if let err = error as? MoyaError {
          
          dump("----> TravelSpotDetail \(err)")
        }
      }
    }
  }
  
  // MARK: - @objc Function Part
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
