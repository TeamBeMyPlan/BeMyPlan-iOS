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
  var viewModel : PlanPreviewViewModel!

  private var isScrabed : Bool = false{
    didSet{
      setScrabImage()
    }
  }
  private var contentList : [PlanPreview.ContentList] = []
  
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
    setScrabImage()
    addButtonActions()
    bindViewModels()
    viewModel.viewDidLoad()
  }
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func previewButtonClicked(_ sender: Any) {
    viewModel.clickPreviewButton()
  }
  
  // MARK: - Custom Method Part
  
  private func bindViewModels(){
    viewModel.didFetchDataStart = { [weak self] in
      self?.showIndicator()
    }
    
    viewModel.didFetchDataFinished = { [weak self] in
      self?.previewContentTV.reloadData()
      self?.closeIndicator{
        UIView.animate(withDuration: 0.4) {
          self?.previewContentTV.alpha = 1
        }
      }
    }
    
    viewModel.networkError = { [weak self] in
      self?.closeIndicator{
        self?.postObserverAction(.showNetworkError)
      }
    }
    
    viewModel.didUpdatePriceData = { [weak self] price in
      self?.priceLabel.text = price
    }
    
    viewModel.movePaymentView = { [weak self] in
      guard let self = self else {return}
      let vc = ModuleFactory.resolve().instantiatePaymentSelectVC(writer: self.viewModel.headerData?.writer,
                                                                  planTitle: self.viewModel.headerData?.title,
                                                                  imgURL: self.viewModel.photoData?.first?.photo,
                                                         price: self.priceLabel.text,
                                                                  postID: self.viewModel.postId)
      self.navigationController?.pushViewController(vc, animated: true)
    }
    
    viewModel.movePreviewDetailView = { [weak self] in
      let vc = ModuleFactory.resolve().instantiatePlanDetailVC(isPreviewPage: true)
      self?.navigationController?.pushViewController(vc, animated: true)
    }
  }
 
  private func addButtonActions(){
    scrabButton.press {
      self.isScrabed = !self.isScrabed
    }
    
    buyButton.press {
      self.viewModel.clickBuyButton()
    }
  }
  
  private func setScrabImage(){
    scrabIconImageView.image = isScrabed ? ImageLiterals.Preview.scrabIconSelected : ImageLiterals.Preview.scrabIcon
  }
}
// MARK: - Extension Part
extension PlanPreviewVC : UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
extension PlanPreviewVC : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.contentList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let viewCase = viewModel.contentList[indexPath.row]
    
    switch(viewCase){
      case .header:
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewWriterTVC.className, for: indexPath) as? PlanPreviewWriterTVC else {return UITableViewCell() }
        headerCell.setHeaderData(author: viewModel.headerData?.writer,
                                 title: viewModel.headerData?.title, authIDs: viewModel.authID)
        return headerCell
        
      case .description:
        guard let descriptionCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewDescriptionTVC.className, for: indexPath) as? PlanPreviewDescriptionTVC else {return UITableViewCell() }
        descriptionCell.setDescriptionData(contentData: viewModel.descriptionData)
        return descriptionCell
        
      case .photo:
        guard let photoCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewPhotoTVC.className, for: indexPath) as? PlanPreviewPhotoTVC else {return UITableViewCell() }
        
        photoCell.setPhotoData(url: viewModel.photoData?[indexPath.row - 2].photo,
                               content: viewModel.photoData?[indexPath.row - 2].content)
        return photoCell
        
      case .summary:
        guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewSummaryTVC.className, for: indexPath) as? PlanPreviewSummaryTVC else {return UITableViewCell()}
        
        summaryCell.setSummaryData(content: viewModel.summaryData?.content)
        return summaryCell
        
      case .recommend:
        guard let recommendCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewRecommendTVC.className, for: indexPath) as? PlanPreviewRecommendTVC else {return UITableViewCell() }
        return recommendCell
    }
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
