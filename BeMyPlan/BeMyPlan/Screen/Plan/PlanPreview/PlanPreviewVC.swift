//
//  PlanPreviewVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView

class PlanPreviewVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  var idx : Int = 29
  private var isAnimationProceed: Bool = false
  private var lastContentOffset : CGFloat = 0
  var viewModel : PlanPreviewViewModel!
  private let disposeBag = DisposeBag()
  private var isScrabed : Bool = false{
    didSet{
      setScrabImage()
    }
  }
  private var contentList : [PlanPreview.ContentList] = []
  private var cachedHeightList: [Int: CGFloat] = [:]
  
  // MARK: - UI Component Part
  
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var scrabButton: UIButton!
  @IBOutlet var buyButton: UIButton!
  @IBOutlet var scrabIconImageView: UIImageView!
  @IBOutlet var headerTitleLabel: UILabel!
  @IBOutlet var previewContentTV: UITableView!{
    didSet{
//      previewContentTV.delegate = self
//      previewContentTV.dataSource = self
      previewContentTV.separatorStyle = .none
      previewContentTV.allowsSelection = false
      previewContentTV.rowHeight = UITableView.automaticDimension
    }
  }
  
  @IBOutlet var buyContainerBottomConstraint: NSLayoutConstraint!
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    setScrabImage()
    addButtonActions()
    bindViewModels()
  }
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func previewButtonClicked(_ sender: Any) {
    
  }
  
  // MARK: - Custom Method Part
  
  private func bindViewModels(){
    let input = PlanPreviewViewModel.Input(
      viewDidLoadEvent:
        self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in })
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.contentList
      .bind(to: previewContentTV.rx.items) { (tableView,index,item) -> UITableViewCell in
        switch(item.case){
          case .header:
            let headerData = item as! PlanPreview.HeaderDataModel
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewWriterTVC.className) as? PlanPreviewWriterTVC else {return UITableViewCell() }
            headerCell.setHeaderData(author: headerData.writer,
                                     title: headerData.title)
            return headerCell
            
          case .description:
            let descriptionData = item as! PlanPreview.DescriptionData
            guard let descriptionCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewDescriptionTVC.className) as? PlanPreviewDescriptionTVC else {return UITableViewCell() }
             descriptionCell.setDescriptionData(contentData: descriptionData)
            return descriptionCell

          case .photo:
            let photoData = item as! PlanPreview.PhotoData
            guard let photoCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewPhotoTVC.className) as? PlanPreviewPhotoTVC else {return UITableViewCell() }
            
            photoCell.heightLoadComplete = { [weak self] height in
              self?.cachedHeightList[index] = height
              print("height VC에서 캐싱됨",self?.cachedHeightList,index)
              self?.previewContentTV.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
            if let height = self.cachedHeightList[index] {
              print("캐싱된 height VC에서 셀로 주입중",height,index)
              photoCell.setPhotoData(photoData,height)
            }else {
              photoCell.setPhotoData(photoData)
            }


            return photoCell
            
          case .summary:
            let summaryData = item as! PlanPreview.SummaryData
            guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewSummaryTVC.className) as? PlanPreviewSummaryTVC else {return UITableViewCell() }
            summaryCell.setSummaryData(content: summaryData.content)
            return summaryCell
            
          case .recommend:
            guard let recommendCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewRecommendTVC.className) as? PlanPreviewRecommendTVC else {return UITableViewCell() }
            return recommendCell
            
        }
      }.disposed(by: disposeBag)
    
    output.priceData
      .asDriver(onErrorJustReturn: "")
      .drive( onNext: { [weak self] price in
          self?.priceLabel.text = (price != nil) ? "\(price!)원" : ""
      })
      .disposed(by: disposeBag)
  }
 
  private func addButtonActions(){
    scrabButton.press {
      self.isScrabed = !self.isScrabed
    }
    
    buyButton.press {
//      self.viewModel.clickBuyButton()
    }
  }
  
  private func setScrabImage(){
    scrabIconImageView.image = isScrabed ? ImageLiterals.Preview.scrabIconSelected : ImageLiterals.Preview.scrabIcon
  }
}
// MARK: - Extension Part

extension PlanPreviewVC : UIScrollViewDelegate{
  func scrollViewDidScroll(_ scrollView: UIScrollView) {

    if scrollView.contentOffset.y > 127{
      headerTitleLabel.alpha = 1
    }else{
      headerTitleLabel.alpha = 0
    }
    
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
