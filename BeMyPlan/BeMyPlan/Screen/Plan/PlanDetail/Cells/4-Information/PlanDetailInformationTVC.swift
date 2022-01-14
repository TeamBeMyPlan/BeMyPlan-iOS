//
//  PlanDetailInformationTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailInformationTVC: UITableViewCell,UITableViewRegisterable {
  
  static var isFromNib: Bool = true
  private var imgUrlList : [String] = ["","",""]
  
  var currentIndex :Int = 0{
    didSet{
      if imgUrlList.count > 0{
        progressBar.setPercentage(ratio: CGFloat((currentIndex + 1)) / CGFloat(imgUrlList.count))
      }else{
        progressBar.setPercentage(ratio: 0)
      }
    }
  }
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var contentCV: UICollectionView!{
    didSet{
      contentCV.delegate = self
      contentCV.dataSource = self
      contentCV.isPagingEnabled = true
      contentCV.bounces = false
    }
  }
  @IBOutlet var progressBar: ProgressBar!{
    didSet{
    }
  }
  @IBOutlet var contentTextView: UITextView!
  @IBOutlet var nextTripTimeView: UIView!
  @IBOutlet var nextTripLocationNameLabel: UILabel!
  @IBOutlet var nextTripTimeLabel: UILabel!
  
  @IBOutlet var nextLocationGuideLabelCenterLayout: NSLayoutConstraint!{
    didSet{
    }
  }
  @IBOutlet var nextLocationGuideLabelWidth: NSLayoutConstraint!{
    didSet{
      nextLocationGuideLabelWidth.constant = screenWidth - 88
    }
  }
  @IBOutlet var addressLabelMaxWidthConstraint: NSLayoutConstraint!{
    didSet{
      addressLabelMaxWidthConstraint.constant = screenWidth - 72
    }
  }
  override func awakeFromNib() {
    super.awakeFromNib()
    registerCells()
    setUI()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  
  //MARK: - IBActions Part
  @IBAction func addressCopyButtonClicked(_ sender: Any) {
    
  }
  
  // MARK: - Custom Methods Parts
  
  private func setUI(){
    contentCV.layer.cornerRadius = 5
    
    contentTextView.textContainerInset = .zero
    contentTextView.textContainer.lineFragmentPadding = .zero
    
    nextTripTimeView.layer.cornerRadius = 5
    nextTripTimeView.layer.borderColor = UIColor.grey04.cgColor
    nextTripTimeView.layer.borderWidth = 1
    
  }
  
  private func setNextLocationLabelCenter(){
    let fullLabelWidth = nextTripTimeLabel.frame.width + nextTripLocationNameLabel.frame.width
    let farWidth = fullLabelWidth / 2 - nextTripLocationNameLabel.frame.width / 2
    nextLocationGuideLabelCenterLayout.constant = -1 * farWidth
  }
  
  func setData(title : String, address : String,
               imgUrls: [String],content : String,nextTravel : PlanDetailData.Summary?){
    if let nextTravel = nextTravel,
       let transportCase = nextTravel.transportCase,
       let time = nextTravel.time{
      nextTripTimeView.isHidden = false
      nextTripTimeLabel.text = transportCase.rawValue + " " + time
      nextTripLocationNameLabel.text = title + " -> " + nextTravel.locationName
    }else{
      nextTripTimeView.isHidden = true
    }
    titleLabel.text = title
    addressLabel.text = address
    contentTextView.text = content
    nextTripLocationNameLabel.sizeToFit()
    nextTripTimeLabel.sizeToFit()
    // 이미지는 나중에 넣어야 함.
    setNextLocationLabelCenter()
  }
  
  private func registerCells(){
    PlanDetailInfoPhotoCVC.register(target: contentCV)
  }
  
}

extension PlanDetailInformationTVC : UICollectionViewDelegate{
  
}

extension PlanDetailInformationTVC : UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imgUrlList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanDetailInfoPhotoCVC.className, for: indexPath) as? PlanDetailInfoPhotoCVC else {return UICollectionViewCell() }
    photoCell.setImage(url: imgUrlList[indexPath.row])
    return photoCell
  }
  
  
}

extension PlanDetailInformationTVC: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = screenWidth - 48
    let cellHeight = cellWidth * (436/327)
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 0 }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 0 }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
}

extension PlanDetailInformationTVC : UIScrollViewDelegate{
  
//  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//    let collectionViewWidth = screenWidth - 48
//
//    let index = scrollView.contentOffset.x / collectionViewWidth
//    print("INDEX",index)
//    print("COLLECTIONVIEWWIDTH",collectionViewWidth)
//    print("saa",scrollView.contentOffset.x)
//    progressBar.setPercentage(ratio: (index + 1) / CGFloat(imgUrlList.count))
//  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let collectionViewWidth = screenWidth - 48

    let point = scrollView.contentOffset.x / collectionViewWidth
    currentIndex = Int(floor(point))
  }

}
