//
//  PlanPreviewVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit
import SkeletonView

class PlanPreviewVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  var idx : Int = 29
  private var isAnimationProceed: Bool = false
  private var lastContentOffset : CGFloat = 0
  private var isScrabed : Bool = false{
    didSet{
      setScrabImage()
    }
  }
  private var contentList : [PlanPreview.ContentList] = []{
    didSet{
      previewContentTV.reloadData()
    }
  }
  
  private var headerData : PlanPreview.HeaderData? { didSet { setContentList() }}
  private var descriptionData : PlanPreview.DescriptionData? { didSet { setContentList() }}
  private var photoData : [PlanPreview.PhotoData]? { didSet { setContentList() }}
  private var summaryData : PlanPreview.SummaryData? { didSet { setContentList() }}
  private var recommendData : PlanPreview.RecommendData?{ didSet { setContentList() }}
  
  // MARK: - UI Component Part
  
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var scrabButton: UIButton!
  @IBOutlet var buyButton: UIButton!
  @IBOutlet var scrabIconImageView: UIImageView!
  @IBOutlet var headerTitleLabel: UILabel!
  @IBOutlet var previewContentTV: UITableView!{
    didSet{
      previewContentTV.alpha = 0
      previewContentTV.delegate = self
      previewContentTV.dataSource = self
      previewContentTV.separatorStyle = .none
      previewContentTV.allowsSelection = false
    }
  }
  
  @IBOutlet var buyContainerBottomConstraint: NSLayoutConstraint!
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchDummyData()
    setScrabImage()
    addButtonActions()
    fetchTagData()
    fetchDetailData()
    showIndicator()
  }
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func previewButtonClicked(_ sender: Any) {
    guard let previewVC = UIStoryboard.list(.planDetail).instantiateViewController(withIdentifier: PlanDetailVC.className) as? PlanDetailVC else {return}
    
    previewVC.isPreviewPage = true
    self.navigationController?.pushViewController(previewVC, animated: true)
  }
  
  // MARK: - Custom Method Part
 
  private func addButtonActions(){
    scrabButton.press {
      self.isScrabed = !self.isScrabed
    }
    buyButton.press {
      guard let paymentVC = UIStoryboard.list(.payment).instantiateViewController(withIdentifier: PaymentSelectVC.className) as? PaymentSelectVC else {return}
      paymentVC.postIdx = self.idx
      if let headerData = self.headerData {
        paymentVC.writer = headerData.writer
        paymentVC.planTitle = headerData.title
      }
      if let photoData = self.photoData,
         let photo = photoData.first?.photo{
        paymentVC.imgURL = photo
      }
      if let price = self.priceLabel.text{
        paymentVC.price = price
      }
      self.navigationController?.pushViewController(paymentVC, animated: true)
    }
  }
  
  private func setContentList(){
    contentList.removeAll()
    if let _ = headerData {
      contentList.append(.header)
    }
    if let _ = descriptionData{
      contentList.append(.description)
    }
    if let photo = photoData{
      for (_,_) in photo.enumerated(){
        contentList.append(.photo)
      }
    }
    if summaryData?.content != ""{
      contentList.append(.summary)
    }
    if let _ = recommendData{
      contentList.append(.recommend)
    }
    previewContentTV.reloadData()
  }
  
  private func fetchTagData(){

    BaseService.default.getPlanPreviewHeaderData(idx: idx) { result in
      result.success { [weak self] data in
        if let data = data{
          
          self?.priceLabel.text = String(data.price) + "원"
          self?.headerData = PlanPreview.HeaderData.init(writer: data.author,
                                                         title: data.title)
          self?.descriptionData = PlanPreview.DescriptionData.init(descriptionContent: data.dataDescription,
                                                                   summary: PlanPreview.IconData.init(theme: data.tagTheme,
                                                                                                      spotCount: String(data.tagCountSpot),
                                                                                                      restaurantCount: String(data.tagCountRestaurant),
                                                                                                      dayCount: String(data.tagCountDay),
                                                                                                      peopleCase: data.tagPartner,
                                                                                                      budget: data.tagMoney,
                                                                                                      transport: data.tagMobility,
                                                                                                      month: String(data.tagMonth)))
        }
      }.catch { err in
        dump(err)
      }
    }
  }
  
  private func fetchDetailData(){
    BaseService.default.getPlanPreviewDetailData(idx: idx) { result in
      result.success { [weak self] data in
        if let data = data{
          
          print("GET SUCCESS")
          dump(data)
          var photoList : [PlanPreview.PhotoData] = []
          for (_,item) in data.enumerated(){
            photoList.append(PlanPreview.PhotoData.init(photo: item.photoUrls.first ?? "",
                                                        content: item.datumDescription))
          }
          self?.photoData = photoList
        }
        self?.closeIndicator{
          UIView.animate(withDuration: 1.0) {
            self?.previewContentTV.alpha = 1
          }
        }
        
      }.catch { err in
        
        self.closeIndicator{
          NotificationCenter.default.post(name: BaseNotiList.makeNotiName(list: .showNetworkError), object: nil)
        }

      }
    }
  }
  
  private func setScrabImage(){
    scrabIconImageView.image = isScrabed ? ImageLiterals.Preview.scrabIconSelected : ImageLiterals.Preview.scrabIcon
  }
  // MARK: - @objc Function Part
  
}
// MARK: - Extension Part
extension PlanPreviewVC : UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
extension PlanPreviewVC : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contentList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let viewCase = contentList[indexPath.row]
    
    switch(viewCase){
      case .header:
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewWriterTVC.className, for: indexPath) as? PlanPreviewWriterTVC else {return UITableViewCell() }
        headerCell.setHeaderData(author: headerData?.writer, title: headerData?.title)
        return headerCell
        
      case .description:
        guard let descriptionCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewDescriptionTVC.className, for: indexPath) as? PlanPreviewDescriptionTVC else {return UITableViewCell() }
        descriptionCell.setDescriptionData(contentData: descriptionData)
        return descriptionCell
        
      case .photo:
        guard let photoCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewPhotoTVC.className, for: indexPath) as? PlanPreviewPhotoTVC else {return UITableViewCell() }
        
        photoCell.setPhotoData(url: photoData?[indexPath.row - 2].photo,
                               content: photoData?[indexPath.row - 2].content)
        return photoCell
        
      case .summary:
        guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewSummaryTVC.className, for: indexPath) as? PlanPreviewSummaryTVC else {return UITableViewCell()}
        
        summaryCell.setSummaryData(content: summaryData?.content)
        return summaryCell
        
      case .recommend:
        guard let recommendCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewRecommendTVC.className, for: indexPath) as? PlanPreviewRecommendTVC else {return UITableViewCell() }
        
        
        return recommendCell
    }
  }
}

// 임시로 데이터 넣는 부분이라 이후에 지울 예정
extension PlanPreviewVC{
  func fetchDummyData(){
    headerData = PlanPreview.HeaderData(writer: "", title: "")
    descriptionData = PlanPreview.DescriptionData(descriptionContent: """
""",
                                                  summary: PlanPreview.IconData(theme: "주제",
                                                                                spotCount: "13곳",
                                                                                restaurantCount: "13개",
                                                                                dayCount: "13일",
                                                                                peopleCase: "친구",
                                                                                budget: "45만원",
                                                                                transport: "버스",
                                                                                month: "3달"))

    summaryData = PlanPreview.SummaryData(content: "")
    recommendData = PlanPreview.RecommendData()
    setContentList()
  }
}

extension PlanPreviewVC : UIScrollViewDelegate{
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if lastContentOffset > scrollView.contentOffset.y && lastContentOffset - 40 < scrollView.contentSize.height - scrollView.frame.height {
      moveBuyContainer(state: .show)
    } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
      
      if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        moveBuyContainer(state: .show)
      }else{
        moveBuyContainer(state: .hide)
      }
    }
    lastContentOffset = scrollView.contentOffset.y
  }
  
  private func moveBuyContainer(state : ViewState){
    if isAnimationProceed == false {
      isAnimationProceed = true
      UIView.animate(withDuration: 0.5) {
        self.buyContainerBottomConstraint.constant = (state == .show) ? 0 : -122
        self.view.layoutIfNeeded()
      } completion: { _ in
        self.isAnimationProceed = false
      }
    }
  }
}


enum ViewState{
  case hide
  case show
}
