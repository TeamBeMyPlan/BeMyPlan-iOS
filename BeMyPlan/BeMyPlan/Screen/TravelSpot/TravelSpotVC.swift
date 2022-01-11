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
         
    }
    
  // MARK: - IBAction Part
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



// MARK: - Extension Part
