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
  
  private let factory: ModuleFactoryProtocol = ModuleFactory.resolve()
  private var isAnimationProceed: Bool = false
  private var lastContentOffset : CGFloat = 0
  private let disposeBag = DisposeBag()
  var scrapState : Bool = false
  var idx : Int = 29

  var viewModel : PlanPreviewViewModel!

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
    bindTableView()
    setScrabImage()
  }

  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Custom Method Part
  private func bindViewModels(){
    let input = PlanPreviewViewModel.Input(
      viewDidLoadEvent:
        self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
      buyButtonDidTapEvent:
        self.buyButton.rx.tap.asObservable(),
      viewPreviewButtonDidTapEvent:
        self.buyButton.rx.tap.asObservable()) // 버튼 바꿔야 됨.
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.pushBuyView.subscribe { [weak self] data in
      guard let self = self else { return }
      if let paymentData = data.element {
        let paymentVC = self.factory.instantiatePaymentSelectVC(paymentData: paymentData)
        self.navigationController?.pushViewController(paymentVC, animated: true)
      }
    }.disposed(by: disposeBag)
    
    output.contentList
      .bind(to: previewContentTV.rx.items) { (tableView,index,item) -> UITableViewCell in
        switch(item.case){
          case .header:
            let headerData = item as! PlanPreview.HeaderDataModel
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: PlanPreviewWriterTVC.className) as? PlanPreviewWriterTVC else {return UITableViewCell() }
            headerCell.setHeaderData(author: headerData.writer,
                                     title: headerData.title,
                                     authorID: headerData.authorID)
            headerCell.writerButtonClicked = { [weak self] nickname, authID in
              self?.moveAuthorPage(nickname: nickname, authID: authID)
            }
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
              self?.previewContentTV.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
            if let height = self.cachedHeightList[index] {
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
            recommendCell.previewButtonDidTap = { [weak self] in
              self?.movePaymentView()
            }
            return recommendCell
            
        }
      }.disposed(by: disposeBag)
    
    output.priceData
      .asDriver(onErrorJustReturn: "")
      .drive( onNext: { [weak self] price in
          self?.priceLabel.text = (price != nil) ? "\(price!)원" : ""
      })
      .disposed(by: disposeBag)
    
    output.contentTitle
      .asDriver(onErrorJustReturn: "")
      .filter{ $0 != nil}
      .drive( onNext: { [weak self] headerTitle in
        self?.headerTitleLabel.text = headerTitle!
      })
      .disposed(by: self.disposeBag)
  }
 
  private func addButtonActions(){
    scrabButton.press {
      self.postScrapAction()
    }
    
    buyButton.press {
//      self.viewModel.clickBuyButton()
    }
  }
  
  private func bindTableView() {
    previewContentTV.rx.contentOffset
      .filter { $0 != nil }
      .subscribe {
        self.setYPosition($0.element!.y)
    }.disposed(by: self.disposeBag)
  }
  
  private func movePaymentView() {
    let previewVC = self.factory.instantiatePlanDetailVC(postID: 0, isPreviewPage: true)
    self.navigationController?.pushViewController(previewVC, animated: true)
  }
  
  private func moveAuthorPage(nickname: String,authID: Int){
    let data = PlanWriterDataModel.init(authorName: nickname,
                                        authorID: authID)
    postObserverAction(.moveNicknamePlanList, object: data)
  }
  
  private func setScrabImage() {
    scrabIconImageView.image = scrapState ? ImageLiterals.Preview.scrabIconSelected : ImageLiterals.Preview.scrabIcon
  }
  
  private func postScrapAction() {
    let dto = ScrapRequestDTO(planID: idx,
                              scrapState: scrapState)
    postObserverAction(.scrapButtonClicked, object: dto)
    scrapState.toggle()
    setScrabImage()
  }
  
  
}
// MARK: - Extension Part

extension PlanPreviewVC{
  func setYPosition(_ yPos: CGFloat) {

    if yPos > 127{
      headerTitleLabel.alpha = 1
    }else{
      headerTitleLabel.alpha = 0
    }
    
    if lastContentOffset > yPos && lastContentOffset - 40 < previewContentTV.contentSize.height - previewContentTV.frame.height {
      moveBuyContainer(state: .show)
    } else if lastContentOffset < yPos && yPos > 0 {
      
      if (yPos >= (previewContentTV.contentSize.height - previewContentTV.frame.size.height)) {
        moveBuyContainer(state: .show)
      }else{
        moveBuyContainer(state: .hide)
      }
    }
    lastContentOffset = yPos
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
