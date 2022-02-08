//
//  TabBarIconView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/07.
//

import UIKit
class TabBarIconView : XibView{
  
  var delegate: TabBarDelegate?
  private var tabType : TabList = .home
  
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!

  @IBAction func TabBarClicked(_ sender: Any) {
    makeVibrate()
    delegate?.tabClicked(index: tabType)
  }
  
  func setTab(tab : TabList, isClicked : Bool){
    tabType = tab
    iconImageView.image = makeTabIcon(tab: tab, isTabClicked: isClicked)
    titleLabel.text = makeTabTitle(tab: tab)
    titleLabel.textColor = isClicked ? UIColor.bemyBlue : UIColor.grey04
  }
  
  private func makeTabIcon(tab: TabList, isTabClicked : Bool) -> UIImage{
    switch(tab){
      case .home:
        return isTabClicked ? ImageLiterals.TabBar.homeIconSelected : ImageLiterals.TabBar.homeIcon
        
      case .travelSpot:
        return isTabClicked ? ImageLiterals.TabBar.travelSpotIconSelected : ImageLiterals.TabBar.travelSpotIcon
        
      case .scrap:
        return isTabClicked ? ImageLiterals.TabBar.scrapIconSelected : ImageLiterals.TabBar.scrapIcon
        
      case .myPlan:
      return isTabClicked ? ImageLiterals.TabBar.myPlanIconSelected : ImageLiterals.TabBar.myPlanIcon    }
  }
  
  private func makeTabTitle(tab: TabList) -> String{
    switch(tab){
      case .home : return I18N.TabBar.home
      case .travelSpot : return I18N.TabBar.travelSpot
      case .scrap : return I18N.TabBar.scrap
      case .myPlan : return I18N.TabBar.myPlan
    }
  }
}

protocol TabBarDelegate{
  func tabClicked(index : TabList)
}
