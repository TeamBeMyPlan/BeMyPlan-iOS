//
//  TravelSpotVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/06.
//
import UIKit
import Moya
import SkeletonView

class TravelSpotVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  var travelSpotDataList: [TravelSpotDataGettable] = []
  var completionHandler: ((Int) -> (Int))?

  // MARK: - UI Component Part
  @IBOutlet var logoView: UIView!
  @IBOutlet var locationCollectionView: UICollectionView!
  @IBOutlet var headerTopConstraint: NSLayoutConstraint!{
    didSet{ headerTopConstraint.constant = calculateTopInset()}
  }
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    configCollectionView()
  }
  
  override func viewDidLayoutSubviews() {
    fetchTravelSpotItemList()
    setSkeletonOptions()
    logoView.layer.applyShadow(color: UIColor(displayP3Red: 0.796, green: 0.796, blue: 0.796, alpha: 0.25), alpha: 1, x: 1, y: 4, blur: 8, spread: 1)
  }
  
  // MARK: - Set Function Part
  func configCollectionView() {
    TravelSpotCVC.register(target: locationCollectionView)
    locationCollectionView.dataSource = self
    locationCollectionView.delegate = self
  }
    
  // MARK: - Custom Method Part
  
  private func setSkeletonOptions(){
    locationCollectionView.isSkeletonable = true
  }
  
  private func fetchTravelSpotItemList() {
    BaseService.default.getTravelSpotList { [weak self] result in
      result.success { data in
        self?.travelSpotDataList = []
        if let testedData = data {
          self?.travelSpotDataList = testedData
          self?.locationCollectionView.reloadData()
        }

      }.catch { error in
        if let _ = error as? MoyaError {
        }
      }
    }
  }
  
  private func makeTravelSpotCase(_ name: String) -> TravelSpotList{
    // FIXME: - 우선 제주밖에 없어서 제주만 return
    return .jeju
  }
}

// MARK: - Extension Part
extension TravelSpotVC: SkeletonCollectionViewDataSource {
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
    return "reusableView"
  }
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return TravelSpotCVC.className
  }
  func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
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
extension TravelSpotVC: SkeletonCollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return travelSpotDataList.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelSpotCVC.className, for: indexPath) as? TravelSpotCVC else {return UICollectionViewCell()}
    cell.setData(data: travelSpotDataList[indexPath.row])
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    _ = completionHandler?(indexPath.row)
    //    self.navigationController?.popViewController(animated: true)
    makeVibrate()
    if !travelSpotDataList[indexPath.row].isActivated {
      postObserverAction(.movePlanList,object: makeTravelSpotCase(travelSpotDataList[indexPath.row].name))
      AppLog.log(at: FirebaseAnalyticsProvider.self, .clickOpenedTravelSpot(spot: travelSpotDataList[indexPath.row].name))
    }else{
      showToast(message: I18N.Alert.notOpenTravelSpot)
      AppLog.log(at: FirebaseAnalyticsProvider.self, .clickClosedTravelSpot(spot: travelSpotDataList[indexPath.row].name))
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
