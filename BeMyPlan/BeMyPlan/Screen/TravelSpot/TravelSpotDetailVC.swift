//
//  TravelSpotDetailVC.swift
//  BeMyPlan
//
//  Created by 조양원 on 2022/01/07.
//

import UIKit
import PanModal

class TravelSpotDetailVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  // MARK: - UI Component Part
  @IBOutlet var contentTableView: UITableView!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    regiterXib()
    setTableViewDelegate()
  }
  
  // MARK: - Set Function Part
  private func setTableViewDelegate() {
    contentTableView.delegate = self
    contentTableView.dataSource = self
  }
  
  private func regiterXib() {
    let xibName = UINib(nibName: TravelSpotDetailTVC.identifier, bundle: nil)
    contentTableView.register(xibName, forCellReuseIdentifier: TravelSpotDetailTVC.identifier)
  }
  
  // MARK: - IBAction Part
  @IBAction func backBtn(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func filterBtn(_ sender: Any) {
    let vc = UIStoryboard(name: "TravelSpot", bundle: nil).instantiateViewController(withIdentifier: "TravelSpotFilterVC") as! TravelSpotFilterVC
    presentPanModal(vc)
  }
  
  // MARK: - Custom Method Part
  
  // MARK: - @objc Function Part
}

// MARK: - Extension Part
extension TravelSpotDetailVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelSpotDetailTVC.identifier) as? TravelSpotDetailTVC else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    cell.titleTextView.text = "가나다라마바사아자차카타파하가나다라마바사아자차카타파하"
    cell.nickNameLabel.text = "yangwon9616yangwon9616yangwon9616"
    cell.contentImage.image = UIImage(named: "img")
    return cell
  }
}

extension TravelSpotDetailVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
//  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//    return UITableView.automaticDimension
//  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
//    let inset = screenHeight * (20/812)
//    let inset = screenWidth * (20/375)
//    return inset
    return 38
  }
}






