//
//  PlanDetailVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailVC: UIViewController {
  
  // MARK: - ViewModels
  
  var viewModel: PlanDetailViewModel!
  var writerContainerViewModel: PlanDetailWriterViewModel! { didSet { setWriterView() }}
  var selectViewModel: PlanDetailSelectDayViewModel!
  var summaryCellViewModel: PlanDetailSummaryViewModel!
  var informationCellViewModels: [PlanDetailInformationViewModel]!

  // MARK: - Vars & Lets Part
  var authID = 0
  var isPreviewPage : Bool = false
  var isFullPage = false { didSet{ foldContentTableView() }}
  var postIdx : Int = 29
  var headerContentHeight : CGFloat = 0
  var headerData : DetailHeaderData?
  var locationList : [[PlanDetailMapData]] = [[]]
  var totalDay : Int = 1
  var initailScrollCompleted = false
  var isSummaryFold = true
  var currentDay : Int = 1
  var summaryList : [[PlanDetail.Summary]] = [[]]
  var infoList : [[PlanDetail.SpotData]] = [[]]
  
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
      mainContainerTV.reloadData()
      isPreviewPage ? setPreviewDummy() : fetchPlanDetailData()
      addObserver()
      showIndicator()
    }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)

//    navigationController?.interactivePopGestureRecognizer?.delegate = nil
//    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
  }
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.removeViewController(PaymentSelectVC.self)
    self.navigationController?.removeViewController(PlanPreviewVC.self)
//    self.navigationController?.removePopGesture()
  }

  // MARK: - Custom Methods Parts
  
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  private func bindViewModel(){
    viewModel.contentFoldState = { [weak self] isFold, headerHeight in
      guard let self = self else {return}
      self.headerTitleLabel.isHidden = !self.isFullPage
      self.mainTVTopConstraint.constant = isFold ? -10 : headerHeight
    }
    
    viewModel.didFetchDataStart = { [weak self] in
      self?.showIndicator()
    }
    
    viewModel.didFetchDataComplete = { [weak self] in
      self?.setMapContainerView()
      self?.mainContainerTV.reloadData()
      self?.setMapContainerView()
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
      self?.selectViewModel = selectDayViewModel
    }
    
    viewModel.didUpdateSummaryCellViewModel = { [weak self] summaryViewModel in
      self?.summaryCellViewModel = summaryViewModel
    }
    
    viewModel.didUpdateinformationCellViewModel = { [weak self] informationViewModelList in
      self?.informationCellViewModels = informationViewModelList
    }
  }
  

  private func addObserver(){
    addObserverAction(.planDetailButtonClicked) { _ in
      self.isFullPage = !self.isFullPage
    }
    
    addObserverAction(.summaryFoldStateChanged) { noti in
      if let state = noti.object as? Bool{
        self.isSummaryFold = state
        self.mainContainerTV.reloadData()
      }
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
    mapContainerView.currentDay = self.viewModel.currentDay - 1
  }
  
  private func foldContentTableView(){
    if isFullPage {
      headerTitleLabel.isHidden = false
      mainTVTopConstraint.constant = -10
    }else{
      headerTitleLabel.isHidden = true
      mainTVTopConstraint.constant = headerContentHeight
    }
    UIView.animate(withDuration: 0.5, delay: 0,
                   options: .curveEaseOut) {
      self.view.layoutIfNeeded()
    } completion: { _ in
      self.postObserverAction(.detailFoldComplete, object: self.isFullPage)
    }

  }

}

extension PlanDetailVC : UITableViewDelegate{
 
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let animation = AnimationFactory.makeFadeAnimation(duration: 0.4, delayFactor: 0.08)
    let animator = Animator(animation: animation)
    animator.animate(cell: cell, at: indexPath, in: tableView)
  }
}

extension PlanDetailVC : UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if viewModel.infoList.count == 0{
      return 0
    }else{
      return viewModel.infoList[viewModel.currentDay - 1].count + 1
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 98
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let selectView = PlanDetailSelectDayView()
    selectView.viewModel = selectViewModel
      selectView.delegate = self
      return selectView
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
      switch(indexPath.row){
        case 0:
          guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryTVC.className, for: indexPath) as? PlanDetailSummaryTVC else {return UITableViewCell() }
          guard summaryList.count >= currentDay-1 else {return UITableViewCell()}
          summaryCell.viewModel = summaryCellViewModel

//          summaryCell.locationList = self.viewModel.summaryList[currentDay - 1]
//          summaryCell.currentDay = currentDay
//          summaryCell.isFold = isSummaryFold
          return summaryCell
          
        default:
          guard viewModel.infoList.count > viewModel.currentDay-1 else {return UITableViewCell()}
          guard viewModel.infoList[viewModel.currentDay-1].count > indexPath.row - 1 else {return UITableViewCell()}
          let spotData = viewModel.infoList[viewModel.currentDay-1][indexPath.row - 1]
         guard let infoCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailInformationTVC.className, for: indexPath) as? PlanDetailInformationTVC else {return UITableViewCell() }
          infoCell.viewModel = self.informationCellViewModels[indexPath.row - 1]
//
//         infoCell.setData(title: spotData.locationTitle,
//                          address: spotData.address,
//                          imgUrls: spotData.imagerUrls,
//                          content: spotData.textContent,
//                          transport: spotData.nextLocationData?.transportCase,
//                          transportTime: spotData.nextLocationData?.time,
//                          nextTravel: infoList[currentDay-1].count > indexPath.row ?
//                          infoList[currentDay-1][indexPath.row].nextLocationData : nil)
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
      mapContainerView.currentIndex = visibleIndex.row
    }
  }
}

extension PlanDetailVC : PlanDetailDayDelegate{
  func dayClicked(day: Int) {
    if viewModel.currentDay != day{
      self.mainContainerTV.scrollToRow(at: IndexPath(row: 0, section: 0 ), at: .top, animated: true)
      viewModel.currentDay = day
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
