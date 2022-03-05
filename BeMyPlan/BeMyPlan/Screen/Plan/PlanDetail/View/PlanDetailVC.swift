//
//  PlanDetailVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit
import ImageSlideShowSwift

class PlanDetailVC: UIViewController {
  
  // MARK: - ViewModels
  
  var viewModel: PlanDetailViewModel!
  var writerContainerViewModel: PlanDetailWriterViewModel! { didSet { setWriterView() }}
  var selectViewModel: PlanDetailSelectDayViewModel! // tableview header
  var summaryCellViewModel: PlanDetailSummaryViewModel! // tableview cell
  var informationCellViewModels: [PlanDetailInformationViewModel]! // tableview cells

  // MARK: - Vars & Lets Part
  
  var isFullPage = false { didSet{ foldContentTableView() }}
  var initailScrollCompleted = false
  
  // MARK: - UI Components Part
  
  @IBOutlet var headerTitleLabel: UILabel!
  @IBOutlet var writerContainerView: PlanDetailWriterContainerView!
  @IBOutlet var mapContainerView: PlanDetailMapContainerView!{
    didSet{
      mapContainerView.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  @IBOutlet var mainContainerTV: UITableView!{
    didSet{
      mainContainerTV.contentInset = .zero
      if #available(iOS 15.0, *) {
        mainContainerTV.sectionHeaderTopPadding = 0
      }
      mainContainerTV.alpha = 0
      mainContainerTV.delegate = self
      mainContainerTV.dataSource = self
      mainContainerTV.allowsSelection = false
      mainContainerTV.separatorStyle = .none
      mainContainerTV.sectionFooterHeight = 0
      mainContainerTV.tableFooterView = UIView()
    }
  }
  // MARK: - Constarints Components Part
  @IBOutlet var writerBlockHeightConstraint: NSLayoutConstraint!
  @IBOutlet var mapContainerHeightConstraint: NSLayoutConstraint!
  @IBOutlet var mainTVTopConstraint: NSLayoutConstraint!
  
  // MARK: - Life Cycle Parts
    override func viewDidLoad() {
      super.viewDidLoad()
      registerCells()
      bindViewModel()
      addObserver()
      viewModel.viewDidLoad()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.removeViewController(PaymentSelectVC.self)
    self.navigationController?.removeViewController(PlanPreviewVC.self)
  }

  // MARK: - Custom Methods Parts
  
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  private func bindViewModel(){
    viewModel.didFetchDataStart = { [weak self] in
      self?.showIndicator()
    }
    
    viewModel.didFetchDataComplete = { [weak self] in
      self?.setMapContainerView()
      self?.mainContainerTV.reloadData()
      self?.closeIndicator {
        UIView.animate(withDuration: 1){
          self?.mainContainerTV.alpha = 1
        }
      }
    }
    
    viewModel.networkError = { [weak self] in
      self?.postObserverAction(.showNetworkError)
    }
    
    viewModel.didUpdateWriterViewModel = { [weak self] writerViewModel in
      self?.writerContainerViewModel = writerViewModel
    }
    
    viewModel.didUpdateSelectDayViewModel = { [weak self] selectDayViewModel in
      guard let self = self else {return}
      self.selectViewModel = selectDayViewModel
      self.mapContainerView.currentDay = self.viewModel.currentDay
    }
    
    viewModel.didUpdateSummaryCellViewModel = { [weak self] summaryViewModel in
      self?.summaryCellViewModel = summaryViewModel
    }
    
    viewModel.didUpdateinformationCellViewModel = { [weak self] informationViewModelList in
      self?.informationCellViewModels = informationViewModelList
    }
    
    viewModel.contentTableViewReload = { [weak self] in
      self?.foldContentTableView()
      self?.mainContainerTV.reloadData()
    }
    
    viewModel.didUpdateWriterBlockHeight = { [weak self] height in
      self?.writerBlockHeightConstraint.constant = height
//      self?.mapContainerHeightConstraint.constant
      self?.view.layoutIfNeeded()
    }
    
    viewModel.showImageSlide = { index,images in
      ImageSlideShowViewController.presentFrom(self) { controller in
        controller.dismissOnPanGesture = true
        controller.slides = images
        controller.enableZoom = true
        controller.initialIndex = index
        controller.view.backgroundColor = .black
      }
    }
  }
  
  private func addObserver(){
    addObserverAction(.planDetailButtonClicked) { _ in
      self.viewModel.bottomContainerFoldChanged()
    }
    
    addObserverAction(.summaryFoldStateChanged) { noti in
      if let state = noti.object as? Bool{
        self.viewModel.summaryFoldChanged(fold: state)
      }
    }
    
    addObserverAction(.copyComplete) { noti in
      self.makeVibrate()
      self.showToast(message: I18N.Alert.copyComplete)
    }
    
  }
  
  private func registerCells(){
    PlanDetailSummaryTVC.register(target: mainContainerTV)
    PlanDetailInformationTVC.register(target: mainContainerTV)
  }
  
  func setWriterView(){
      writerContainerView.viewModel = writerContainerViewModel
  }
  
  func setMapContainerView(){
    mapContainerView.mapPointList = self.viewModel.locationList
    mapContainerView.currentDay = self.viewModel.currentDay
  }
  
  private func foldContentTableView(){
    if viewModel.isFullPage {
      headerTitleLabel.isHidden = false
      mainTVTopConstraint.constant = -10
    }else{
      headerTitleLabel.isHidden = true
      mainTVTopConstraint.constant = viewModel.writerBlockHeight + viewModel.mapContainerHeight
    }
    UIView.animate(withDuration: 0.3, delay: 0,
                   options: .curveEaseOut) {
      self.view.layoutIfNeeded()
    }
  }
}

extension PlanDetailVC : UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension PlanDetailVC : UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if informationCellViewModels == nil{
      return 0
    }else{
      return informationCellViewModels.count + 1
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 98 }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 0 }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if selectViewModel != nil {
      let selectView = PlanDetailSelectDayView()
      selectView.viewModel = selectViewModel
      selectView.delegate = self
      return selectView
    }else{
      return UIView()
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
      switch(indexPath.row){
        case 0:
          guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryTVC.className, for: indexPath) as? PlanDetailSummaryTVC else {return UITableViewCell() }
          summaryCell.viewModel = summaryCellViewModel
          return summaryCell
          
        default:
          guard informationCellViewModels.count >= indexPath.row else {return UITableViewCell() }
         guard let infoCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailInformationTVC.className, for: indexPath) as? PlanDetailInformationTVC else {return UITableViewCell() }
          infoCell.viewModel = self.informationCellViewModels[indexPath.row - 1]
          infoCell.clickImageClosure = { [weak self] idx,urls in
            self?.viewModel.clickPhotos(index: idx, urls: urls)
          }
         return infoCell
      }
  }
}

extension PlanDetailVC : UIScrollViewDelegate{
  func scrollViewDidScroll(_ scrollView: UIScrollView){
    if initailScrollCompleted == false{
      mapContainerView.currentDay = viewModel.currentDay
      initailScrollCompleted = true
    }

    let visiblePoints = CGPoint(x: 0, y: scrollView.contentOffset.y + 210)
    let visibleIndex = mainContainerTV.indexPathForRow(at: visiblePoints)
    if let visibleIndex = visibleIndex {
      if mapContainerView.currentIndex != visibleIndex.row{
        mapContainerView.currentIndex = visibleIndex.row
      }
    }
  }
}

extension PlanDetailVC : PlanDetailDayDelegate{
  func dayClicked(day: Int) {
    if viewModel.currentDay != day{
      self.mainContainerTV.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
      viewModel.currentDayChanged(day: day)
    }

  }
}

extension UINavigationController {
  func popBack(_ nb: Int) {
      if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
          guard viewControllers.count < nb else {
              self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
              return
          }
      }
  }
  
  func removeViewController(_ controller: UIViewController.Type) {
      if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
          viewController.removeFromParent()
      }
  }
}

extension PlanDetailVC : UIGestureRecognizerDelegate {
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
  
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return false
  }
}
