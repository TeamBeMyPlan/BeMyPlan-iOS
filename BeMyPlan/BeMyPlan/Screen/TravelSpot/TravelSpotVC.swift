//
//  TravelSpotVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/06.
//
import UIKit

class TravelSpotVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  let screenWidth = UIScreen.main.bounds.width
  
  @IBOutlet var logoView: UIView!{
    didSet {
      self.logoView.layer.applyShadow(color: UIColor(displayP3Red: 0.796, green: 0.796, blue: 0.796, alpha: 0.25), alpha: 1, x: 1, y: 4, blur: 8, spread: 1)
    }
  }
  @IBOutlet var locationCollectionView: UICollectionView!
  
  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    configCollectionView()
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
  
  // MARK: - @objc Function Part
}

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
    return 20
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelSpotCVC.identifier, for: indexPath) as? TravelSpotCVC else {return UICollectionViewCell()}
    cell.layer.cornerRadius = 5
    cell.lockImageView.image = UIImage(named: "imgLayer")
    cell.locationImageView.image = UIImage(named: "img")
    cell.locationLabel.text = "서울"
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TravelSpotDetailVC") as? TravelSpotDetailVC else {return}
    self.navigationController?.pushViewController(nextVC, animated: true)
  }
}

extension TravelSpotVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = screenWidth * (156/375)
    return CGSize(width: cellWidth, height: cellWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    let inset = screenHeight * (20/812)
    let inset = screenWidth * (20/375)
    return inset
  }
}
