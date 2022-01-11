//
//  PlanDetailVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailVC: UIViewController {

  // MARK: - Vars & Lets Part

  // MARK: - UI Components Part
  
  @IBOutlet var mainContainerTV: UITableView!{
    didSet{
      mainContainerTV.delegate = self
      mainContainerTV.dataSource = self
      mainContainerTV.allowsSelection = false
    }
  }
  // MARK: - Life Cycle Parts
    override func viewDidLoad() {
        super.viewDidLoad()
      registerCells()

    }
  
  // MARK: - Custom Methods Parts
  
  private func registerCells(){
    PlanPreviewWriterTVC.register(target: mainContainerTV)
    PlanDetailMapContainerTVC.register(target: mainContainerTV)
    PlanDetailSelectDayTVC.register(target: mainContainerTV)
    PlanDetailSummaryTVC.register(target: mainContainerTV)
    PlanDetailInformationTVC.register(target: mainContainerTV)
  }
}


extension PlanDetailVC : UITableViewDelegate{
  
}

extension PlanDetailVC : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  
}
