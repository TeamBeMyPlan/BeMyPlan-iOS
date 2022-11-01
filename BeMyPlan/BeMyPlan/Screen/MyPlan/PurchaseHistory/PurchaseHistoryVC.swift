//
//  PurchaseHistoryVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/08/07.
//

import UIKit

class PurchaseHistoryVC: UIViewController {
  
  private var contentList: [PurchaseHistoryDataSource] = [] {
    didSet { setCountLabel() }
  }
  
  @IBOutlet var totalCountLabel: UILabel!
  @IBOutlet var backButton: UIButton!
  @IBOutlet var historyTV: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    AppLog.log(at: FirebaseAnalyticsProvider.self, .view_plan_list_purchased)
    setUI()
    registerCells()
    setDelegate()
    setDummy()
  }
  
}

extension PurchaseHistoryVC {
  private func setUI() {
    historyTV.showsVerticalScrollIndicator = false
    historyTV.bounces = false
    historyTV.allowsSelection = false
    historyTV.separatorStyle = .none
  }
  
  private func setDelegate() {
    historyTV.delegate = self
    historyTV.dataSource = self
  }
  
  private func registerCells() {
    PurhcaseHistoryTVC.register(target: historyTV)
    PurchaseHistoryDateCell.register(target: historyTV)
  }
  
  private func setDummy() {
    contentList.removeAll()
    contentList.append(PurhcaseHistoryDateModel())
    contentList.append(PurchaseHistoryContentModel(title: "111", price: "1,000원"))
    
    contentList.append(PurhcaseHistoryDateModel(type: .date, date: "20.00.00"))
    contentList.append(PurchaseHistoryContentModel(title: "222", price: "4,000원"))
    contentList.append(PurchaseHistoryContentModel(title: "223", price: "4,000원"))
    contentList.append(PurchaseHistoryContentModel(title: "224", price: "4,000원"))
    
    contentList.append(PurhcaseHistoryDateModel(type: .date, date: "20.01.00"))
    contentList.append(PurchaseHistoryContentModel(title: "333", price: "4,000원"))
    
    contentList.append(PurhcaseHistoryDateModel(type: .date, date: "20.02.00"))
    contentList.append(PurchaseHistoryContentModel(title: "444", price: "4,000원"))
    
    contentList.append(PurhcaseHistoryDateModel(type: .date, date: "20.02.00"))
    contentList.append(PurchaseHistoryContentModel(title: "555", price: "4,000원"))
    historyTV.reloadData()
  }
  
  private func setCountLabel() {
    let contentCount = contentList.filter { $0.type == .content }.count
    totalCountLabel.text = "전체 \(contentCount)"
  }
}

extension PurchaseHistoryVC: UITableViewDelegate {
  
}

extension PurchaseHistoryVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contentList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch(contentList[indexPath.row].type) {
      case .date:
        let dateModel = contentList[indexPath.row] as! PurhcaseHistoryDateModel
        guard let dateCell = tableView.dequeueReusableCell(withIdentifier: PurchaseHistoryDateCell.className, for: indexPath)
                as? PurchaseHistoryDateCell else { return UITableViewCell() }
        dateCell.setLabel(dateModel.date)
        return dateCell
      
      case .content:
        let contentModel = contentList[indexPath.row] as! PurchaseHistoryContentModel
        guard let contentCell = tableView.dequeueReusableCell(withIdentifier: PurhcaseHistoryTVC.className, for: indexPath)
                as? PurhcaseHistoryTVC else { return UITableViewCell() }
        contentCell.setDataModel(contentModel)
        return contentCell
    }
  }
  
}

protocol PurchaseHistoryDataSource {
  var type: PurchaseHistoryCellType { get set }
}
enum PurchaseHistoryCellType {
  case date
  case content
}

struct PurhcaseHistoryDateModel: PurchaseHistoryDataSource {
  var type: PurchaseHistoryCellType = .date
  var date: String = "2022.06.28"
}

struct PurchaseHistoryContentModel: PurchaseHistoryDataSource {
  var type: PurchaseHistoryCellType = .content
  var title: String
  var price: String
}
