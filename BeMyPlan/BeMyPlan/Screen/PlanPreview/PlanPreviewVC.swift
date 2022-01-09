//
//  PlanPreviewVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/08.
//

import UIKit

class PlanPreviewVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
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
  
  @IBOutlet var headerTitleLabel: UILabel!
  @IBOutlet var previewContentTV: UITableView!{
    didSet{
      previewContentTV.delegate = self
      previewContentTV.dataSource = self
      previewContentTV.separatorStyle = .none
    }
  }
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - IBAction Part
  
  // MARK: - Custom Method Part
  
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
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? PlanPreviewWriterTVC else {return}
        
        let headerCell = tableView.de
        
        return headerCell
      case .description:
        tableView.dequeueCell(cell: <#T##UITableViewCell#>, indexPath: <#T##IndexPath#>, Type: <#T##T#>)
      case .photo:
        <#code#>
      case .summary:
        <#code#>
      case .recommend:
        <#code#>
    }
  }
  
  
}


