//
//  PlanPreviewVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit

class PlanPreviewVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
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
  
  private var headerData : PlanPreview.HeaderData?
  private var descriptionData : PlanPreview.DescriptionData?
  private var photoData : [PlanPreview.PhotoData]?
  private var summaryData : PlanPreview.SummaryData?
  private var recommendData : PlanPreview.RecommendData?
  
  // MARK: - UI Component Part
  
  @IBOutlet var scrabButton: UIButton!
  @IBOutlet var buyButton: UIButton!
  @IBOutlet var scrabIconImageView: UIImageView!
  @IBOutlet var headerTitleLabel: UILabel!
  @IBOutlet var previewContentTV: UITableView!{
    didSet{
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
  }
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  // MARK: - Custom Method Part
  
  private func addButtonActions(){
    scrabButton.press {
      self.isScrabed = !self.isScrabed
    }
    buyButton.press {
      guard let paymentVC = UIStoryboard.list(.payment).instantiateViewController(withIdentifier: PaymentSelectVC.className) as? PaymentSelectVC else {return}
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
    if let _ = summaryData{
      contentList.append(.summary)
    }
    if let _ = recommendData{
      contentList.append(.recommend)
    }
    previewContentTV.reloadData()
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
        
        recommendCell.setRecommendData(title: recommendData?.title, content: recommendData?.content)
        
        return recommendCell
    }
  }
}

// 임시로 데이터 넣는 부분이라 이후에 지울 예정
extension PlanPreviewVC{
  func fetchDummyData(){
    headerData = PlanPreview.HeaderData(writer: "혜화동불가마", title: "감성을 느낄 수 있는 힐링여행정말 어디깢 ㅣ할 수 있ㅎ는건ㄹㄴ가????ㅁㄴㅇ?????ㅁㅇㄴ라ㅗㅁㄴ아럼나ㅓㅇㄹ")
    descriptionData = PlanPreview.DescriptionData(descriptionContent: """
안녕하세요!
친구와 함께 다녀온 제주 힐링 여행을 콘텐츠로 담아봤어요. 저는 평소에 국내 여행을 다닐 때 대표 관광지나 사람이 너무 많은 핫플보다는, 여유를 느낄 수 있는 공간들을 선호하는 편이에요!
이번 여행 일정 콘텐츠에서도 자연과 감성을 담은 곳들 위주로 일정을 짜고 여행을 다녀왔어요.
저와 비슷한 취향을 가지신 분들이라면 제 일정대로 따라가보세요😎
""",
                                                  summary: PlanPreview.IconData(theme: "주제",
                                                                                spotCount: "13곳",
                                                                                restaurantCount: "13개",
                                                                                dayCount: "13일",
                                                                                peopleCase: "친구",
                                                                                budget: "45만원",
                                                                                transport: "버스",
                                                                                month: "3달"))
    photoData = [
      PlanPreview.PhotoData(photo: "https://picsum.photos/id/1/300/300", content: "첫번째"),
      PlanPreview.PhotoData(photo: "https://picsum.photos/id/1/300/300", content: "두번째"),
      PlanPreview.PhotoData(photo: "https://picsum.photos/id/1/300/300", content: "세번째"),
      PlanPreview.PhotoData(photo: "https://picsum.photos/id/1/300/300", content: "네번째"),
      PlanPreview.PhotoData(photo: "https://picsum.photos/id/1/300/300", content: "다섯번째")
    ]
    summaryData = PlanPreview.SummaryData(content: "여유로운 3박 4일 일정이었는데 타이트하게 잡는다면 꽉 채운 2박 3일도 가능할 것 같은 일정이에요 ㅎㅎ 자연 보면서 힐링 할 수 있는 여행지와 감성가득한 카페, 맛있는 식사만 있어도 여행은 충분하지 ! 라고 생각하시는 분이라면 제 일정대로 따라가보시면 좋을 것 같습니다 :)")
    recommendData = PlanPreview.RecommendData()
    setContentList()
  }
}

extension PlanPreviewVC : UIScrollViewDelegate{
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
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
        self.buyContainerBottomConstraint.constant = (state == .show) ? -34 : -156
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
