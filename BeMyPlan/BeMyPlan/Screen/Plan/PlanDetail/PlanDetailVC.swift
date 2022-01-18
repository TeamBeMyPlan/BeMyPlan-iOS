//
//  PlanDetailVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailVC: UIViewController {

  

  // MARK: - Vars & Lets Part
  var postIdx : Int = 5
  
  var headerData : DetailHeaderData?
  var locationList : [[PlanDetailMapData]] = [[]]
  var totalDay : Int = 1
  var currentDay : Int = 1
  var summaryList : [[PlanDetail.Summary]] = [[]]
  var infoList : [[PlanDetail.SpotData]] = [[]]

  private var writerBlockHeight :CGFloat = 0
  

  // MARK: - UI Components Part
  
  @IBOutlet var headerTitleLabel: UILabel!
  @IBOutlet var mainContainerTV: UITableView!{
    didSet{
      mainContainerTV.delegate = self
      mainContainerTV.dataSource = self
      mainContainerTV.allowsSelection = false
      mainContainerTV.separatorStyle = .none
      mainContainerTV.sectionFooterHeight = 0
      mainContainerTV.tableFooterView = UIView()
    }
  }
  // MARK: - Life Cycle Parts
    override func viewDidLoad() {
      super.viewDidLoad()
      registerCells()
      mainContainerTV.reloadData()
      setHeaderTitle()
      getWriterBlockHeight()
    }
  
  // MARK: - Custom Methods Parts
  
  private func registerCells(){
    PlanDetailWriterTVC.register(target: mainContainerTV)
    PlanDetailMapContainerTVC.register(target: mainContainerTV)
    PlanDetailSummaryTVC.register(target: mainContainerTV)
    PlanDetailInformationTVC.register(target: mainContainerTV)
  }
  
  private func getWriterBlockHeight(){
    headerTitleLabel.isHidden = true
    let writerFrame = mainContainerTV.rectForRow(at: IndexPath(row: 0, section: 0))
    writerBlockHeight = writerFrame.height
  }
  
  private func setHeaderTitle(){
    headerTitleLabel.text = "감성을 느낄 수 있는 힐링여행"
  }

}

extension PlanDetailVC : UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

extension PlanDetailVC : UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch(section){
      case 0: return (headerData != nil) ? 1 : 0
      case 1: return (!locationList.isEmpty) ? 1 : 0
      default : return !infoList.isEmpty ? infoList.count + 1 : 0
    }
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return section == 2 ? 57 : 0
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section == 2{
      let selectView = PlanDetailSelectDayView()
      selectView.totalDay = totalDay
      selectView.delegate = self
      return selectView
    }else{
      return UIView()
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section == 0{
      guard let writerCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailWriterTVC.className, for: indexPath) as? PlanDetailWriterTVC else {return UITableViewCell() }
      if let headerData = headerData{
        writerCell.setTitleData(title: headerData.title,
                                writer: headerData.writer)
        return writerCell
      }else{
        return UITableViewCell()
      }
    }else if indexPath.section == 1{
      guard let mapCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailMapContainerTVC.className, for: indexPath) as? PlanDetailMapContainerTVC else {return UITableViewCell() }
//      mapCell.contentView.disab
      return mapCell
    }else{
      switch(indexPath.row){
        case 0:
          guard let summaryCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailSummaryTVC.className, for: indexPath) as? PlanDetailSummaryTVC else {return UITableViewCell() }
          summaryCell.summaryList = self.summaryList
          return summaryCell
          
        default:
          guard infoList.count >= currentDay-1 else {return UITableViewCell()}
          let spotData = infoList[currentDay-1][indexPath.row - 1]
         guard let infoCell = tableView.dequeueReusableCell(withIdentifier: PlanDetailInformationTVC.className, for: indexPath) as? PlanDetailInformationTVC else {return UITableViewCell() }
         infoCell.setData(title: spotData.locationTitle,
                          address: spotData.address,
                          imgUrls: spotData.imagerUrls,
                          content: spotData.textContent,
                          nextTravel: spotData.nextLocationData)
         return infoCell
      }
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
  }

}


extension PlanDetailVC : PlanDetailDayDelegate{
  func dayClicked(day: Int) {
    currentDay = day
  }
}
