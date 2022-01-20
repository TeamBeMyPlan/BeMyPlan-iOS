//
//  TravelSpotVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/06.
//
import UIKit
import Moya

class TravelSpotVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  var travelSpotDataList: [TravelSpotDataGettable] = []
  let screenWidth = UIScreen.main.bounds.width
  var completionHandler: ((Int) -> (Int))?

  // MARK: - UI Component Part
  @IBOutlet var logoView: UIView!{
    didSet {
      self.logoView.layer.applyShadow(color: UIColor(displayP3Red: 0.796, green: 0.796, blue: 0.796, alpha: 0.25), alpha: 1, x: 1, y: 4, blur: 8, spread: 1)
    }
  }
  @IBOutlet var locationCollectionView: UICollectionView!
  @IBOutlet var headerTopConstraint: NSLayoutConstraint!{
    didSet{ headerTopConstraint.constant = calculateTopInset()}
  }
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    configCollectionView()
    fetchTravelSpotItemList()
  }
  
  // MARK: - Set Function Part
  func configCollectionView() {
    let nibName = UINib(nibName: TravelSpotCVC.identifier, bundle: nil)
    locationCollectionView.register(nibName, forCellWithReuseIdentifier: TravelSpotCVC.identifier)
    locationCollectionView.dataSource = self
    locationCollectionView.delegate = self
  }
  
  // MARK: - IBAction Part
  
  // MARK: - Custom Method Part
  
  private func fetchTravelSpotItemList() {
    BaseService.default.getTravelSpotList { result in
      result.success { data in
        self.travelSpotDataList = []

        if let testedData = data {
          self.travelSpotDataList = testedData
        }
        self.locationCollectionView.reloadData()
      }.catch { error in
        if let err = error as? MoyaError {
        }
      }
    }
  }
}

// MARK: - @objc Function Part


// MARK: - Extension Part
extension TravelSpotVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableView", for: indexPath)
    return headerView
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width: CGFloat = collectionView.frame.width
    let height: CGFloat = 106
    return CGSize(width: width, height: height)
  }
}


extension TravelSpotVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return travelSpotDataList.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelSpotCVC.identifier, for: indexPath) as? TravelSpotCVC else {return UICollectionViewCell()}
    
    cell.setData(data: travelSpotDataList[indexPath.row])
    if travelSpotDataList[indexPath.row].isActivated == true {
      cell.lockImageView.isHidden = true
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    _ = completionHandler?(indexPath.row)
    //    self.navigationController?.popViewController(animated: true)
    if travelSpotDataList[indexPath.row].isActivated {
      NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .movePlanList), object: travelSpotDataList[indexPath.row].id)
    }
  }
}

extension TravelSpotVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = screenWidth * (156/375)
    return CGSize(width: cellWidth, height: cellWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let inset = screenWidth * (20/375)
    return inset
  }
}
