//
//  PlanDetailVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailVC: UIViewController {

  // MARK: - Vars & Lets Part
  var isFullPage = false { didSet{ foldContentTableView() }}
  var postIdx : Int = 3
  var headerContentHeight : CGFloat = 0
  var headerData : DetailHeaderData?
  var locationList : [[PlanDetailMapData]] = [[]]
  var totalDay : Int = 1
  var currentDay : Int = 1 { didSet{mainContainerTV.reloadData()} }
  var summaryList : [[PlanDetail.Summary]] = [[]]
  var infoList : [[PlanDetail.SpotData]] = [[]]

  private var writerBlockHeight :CGFloat = 0
  

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
//      mainContainerTV.contentInsetAdjustmentBehavior = .never
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
      getWriterBlockHeight()
      fetchPlanDetailData()
      addObserver()
    }
  
  // MARK: - Custom Methods Parts
  
  private func addObserver(){
    addObserverAction(keyName: NSNotification.Name.init(rawValue: "planDetailButtonClicked")) { _ in
      self.isFullPage = !self.isFullPage
    }
  }
  
  private func registerCells(){
    PlanDetailSummaryTVC.register(target: mainContainerTV)
    PlanDetailInformationTVC.register(target: mainContainerTV)
  }
  
  private func getWriterBlockHeight(){
    headerTitleLabel.isHidden = true
    let writerFrame = mainContainerTV.rectForRow(at: IndexPath(row: 0, section: 0))
    writerBlockHeight = writerFrame.height
  }
  
  func setWriterView(){
    if let headerData = headerData{
      writerContainerView.setTitleData(title: headerData.writer,
                              writer: headerData.title)
    }
  }
  
  func setMapContainerView(){
    mapContainerView.mapPointList = self.locationList
    mapContainerView.currentDay = self.currentDay - 1
  }
  
  private func foldContentTableView(){
    if isFullPage {
      mainTVTopConstraint.constant = -10
    }else{
      mainTVTopConstraint.constant = headerContentHeight
    }
    UIView.animate(withDuration: 0.5, delay: 0,
                   options: .curveEaseOut) {
      self.view.layoutIfNeeded()
    } completion: { _ in
      NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "detailFoldComplete"), object: self.isFullPage)
    }

  }

}

extension PlanDetailVC : UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  
    return UITableView.automaticDimension
  }
  
   
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let animation = AnimationFactory.makeFadeAnimation(duration: 0.6, delayFactor: 0.08)
    let animator = Animator(animation: animation)
    animator.animate(cell: cell, at: indexPath, in: tableView)
  }
}

extension PlanDetailVC : UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return !infoList.isEmpty ? infoList.count + 1 : 0
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
      selectView.totalDay = totalDay
      selectView.currentDay = currentDay
    selectView.setFoldImage(isFolded: isFullPage)
      selectView.delegate = self
      return selectView
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
      switch(indexPath.row){
        case 0:
          guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryTVC.className, for: indexPath) as? PlanDetailSummaryTVC else {return UITableViewCell() }
          guard summaryList.count >= currentDay-1 else {return UITableViewCell()}
          summaryCell.summaryList = self.summaryList[currentDay - 1]
          summaryCell.currentDay = currentDay
          return summaryCell
          
        default:
          
          guard infoList.count > currentDay-1 else {return UITableViewCell()}
          guard infoList[currentDay-1].count > indexPath.row - 1 else {return UITableViewCell()}
          let spotData = infoList[currentDay-1][indexPath.row - 1]
         guard let infoCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailInformationTVC.className, for: indexPath) as? PlanDetailInformationTVC else {return UITableViewCell() }
         infoCell.setData(title: spotData.locationTitle,
                          address: spotData.address,
                          imgUrls: spotData.imagerUrls,
                          content: spotData.textContent,
                          transport: spotData.nextLocationData?.transportCase,
                          transportTime: spotData.nextLocationData?.time,
                          nextTravel: infoList[currentDay-1].count > indexPath.row ?
                          infoList[currentDay-1][indexPath.row].nextLocationData : nil)
         return infoCell
      }
  }
}


extension PlanDetailVC : UIScrollViewDelegate{
  func scrollViewDidScroll(_ scrollView: UIScrollView){
    if writerBlockHeight <= scrollView.contentOffset.y{
      headerTitleLabel.isHidden = false
    }else{
      headerTitleLabel.isHidden = true
    }
//    if scrollView.contentOffset.y <= headerContentHeight + 10{
//      mainTVTopConstraint.constant = headerContentHeight - scrollView.contentOffset.y
//    }else{
//      mainTVTopConstraint.constant = -10
//    }
  }
}

extension PlanDetailVC : PlanDetailDayDelegate{
  func dayClicked(day: Int) {
    if self.currentDay != day{
      var cells : [UITableViewCell] = []
      self.mainContainerTV.scrollToRow(at: IndexPath(row: 0, section: 0 ), at: .top, animated: true)
    }
    self.currentDay = day
  }
}
