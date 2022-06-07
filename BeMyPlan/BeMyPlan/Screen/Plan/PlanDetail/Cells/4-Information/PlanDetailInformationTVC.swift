//
//  PlanDetailInformationTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit
import SkeletonView
import CoreLocation

struct PlanDetailInformationViewModel{
  let title: String
  let latitude: Double
  let longtitude: Double
  let imgUrls: [String]
  let content: String
  let transport: TransportCase?
  let transportTime: String?
  let nextTravel: PlanDetail.Summary?
}

class PlanDetailInformationTVC: UITableViewCell,UITableViewRegisterable {
  
  // MARK: - Models
  var viewModel: PlanDetailInformationViewModel! {
    didSet { configure() }
  }
  private var lastPointee : CGFloat = 0
  static var isFromNib: Bool = true

  var clickImageClosure: ((Int,[String]) -> Void)?
  var currentIndex :Int = 0{
    didSet{
      if viewModel.imgUrls.count >= 1{
        progressBar.setPercentage(ratio: CGFloat((currentIndex + 1)) / CGFloat(viewModel.imgUrls.count))
      }else{
        progressBar.setPercentage(ratio: 0)
      }
    }
  }
  var nextLocationName: String?
  
  // MARK: - UI Components

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
  @IBOutlet var progressBar: ProgressBar!
  @IBOutlet var contentTextView: UITextView!{
    didSet{
      let style = NSMutableParagraphStyle()
      style.lineHeightMultiple = 1.3
      let attributes = [NSAttributedString.Key.paragraphStyle: style]  as [NSAttributedString.Key: Any]
      
      contentTextView.attributedText = NSAttributedString(
        string: contentTextView.text,
        attributes: attributes)
      
      contentTextView.font = UIFont.systemFont(ofSize: 14)
      contentTextView.textColor = .grey01
      contentTextView.textContainer.lineFragmentPadding = .zero
    }
  }
  @IBOutlet var nextTripTimeView: UIView!
  @IBOutlet var nextTripLocationNameLabel: UILabel!
  @IBOutlet var nextTripTimeLabel: UILabel!
  
  @IBOutlet var nextLocationGuideLabelCenterLayout: NSLayoutConstraint!
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
    configureSkeleton()
  }
  
  override func prepareForReuse() {
    configureSkeleton()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: - IBActions Part
  @IBAction func addressCopyButtonClicked(_ sender: Any) {
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickAddressCopy)

    UIPasteboard.general.string = addressLabel.text ?? "" 
    postObserverAction(.copyComplete)
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
  
  private func configureSkeleton() {
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    titleLabel
      .showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .grey04,secondaryColor: .grey06), animation: animation)
  }
  
  private func findLocation(latitude: Double, longtitude: Double) {
    let findLocation = CLLocation(latitude: latitude, longitude: longtitude)
    let geocoder = CLGeocoder()
    let locale = Locale(identifier: "Ko-kr")
    geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
        if let address: [CLPlacemark] = placemarks {
          
          if let addressData: CLPlacemark = address.last{
          
            self.addressLabel.text =  (addressData.locality ?? "") + " " +
                                      (addressData.thoroughfare ?? "") + " " +
                                      (addressData.name ?? "")
            
              self.addressLabel.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            }
        }
    })
  }
  
  private func configure(){
    if let transportCase = viewModel.transport,
       let nextTime = viewModel.transportTime,
       let nextLocationName = nextLocationName{
      nextTripTimeView.isHidden = false
      nextTripTimeLabel.text = transportCase.rawValue + " " + nextTime
      nextTripLocationNameLabel.text = viewModel.title + " -> " + nextLocationName
    }else{
      nextTripTimeView.isHidden = true
    }
    titleLabel.text = viewModel.title
    contentTextView.text = viewModel.content

    self.contentTextView.font = .systemFont(ofSize: 15)

    let fullText = viewModel.content
    let tipRange = (fullText as NSString).range(of: I18N.PlanDetail.tipsHeaderTitle)
    let reviewRange = (fullText as NSString).range(of: I18N.PlanDetail.reviewHeaderTitle)
    let attributedString = NSMutableAttributedString(string: fullText)
    
    attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: tipRange)
    attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: reviewRange)
    
    self.contentTextView.attributedText = attributedString
    
    contentTextView.attributedText = attributedString

//    contentTextView.setTargetAttributedText(targetString: I18N.PlanDetail.tipsHeaderTitle, fontType: UIFont.boldSystemFont(ofSize: 20), text:  viewModel.content)
    nextTripLocationNameLabel.sizeToFit()
    nextTripTimeLabel.sizeToFit()
    setNextLocationLabelCenter()
    findLocation(latitude: viewModel.latitude, longtitude: viewModel.longtitude)
    if viewModel.imgUrls.count > 1{
      progressBar.isHidden = false
      progressBar.setPercentage(ratio: CGFloat((currentIndex + 1)) / CGFloat(viewModel.imgUrls.count))
    }else{
      progressBar.isHidden = true
    }
    contentCV.reloadData()
  }
  
  private func registerCells(){
    PlanDetailInfoPhotoCVC.register(target: contentCV)
  }
  
}
extension PlanDetailInformationTVC : UICollectionViewDataSource{

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    clickImageClosure?(indexPath.row, viewModel.imgUrls)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.imgUrls.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanDetailInfoPhotoCVC.className, for: indexPath) as? PlanDetailInfoPhotoCVC else {return UICollectionViewCell() }
    photoCell.setImage(url: viewModel.imgUrls[indexPath.row])
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
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let collectionViewWidth = screenWidth - 48
    let point = scrollView.contentOffset.x / collectionViewWidth

    if lastPointee <= scrollView.contentOffset.x{
      currentIndex = Int(ceil(point))
    }else{
      currentIndex = Int(floor(point))
    }
    lastPointee = scrollView.contentOffset.x
  }
}



