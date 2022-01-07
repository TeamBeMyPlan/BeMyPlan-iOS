//
//  BaseContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/06.
//

import UIKit

enum TabList{
  case home
  case travelSpot
  case scrap
  case myPlan
}

class BaseContainerView: XibView{

  func getTabVC(_ tab: TabList) -> UIViewController{
    switch(tab){
      case .home:
        let homeVC = UIStoryboard.list(.home).instantiateViewController(withIdentifier: HomeVC.className)
        return homeVC
        
      case .travelSpot:
        let spotVC = UIStoryboard.list(.travelSpot).instantiateViewController(withIdentifier: TravelSpotVC.className)
        return spotVC
        
      case .scrap:
        let scrapVC = UIStoryboard.list(.scrap).instantiateViewController(withIdentifier: ScrapVC.className)
        return scrapVC
        
      case .myPlan:
        let myPlanVC = UIStoryboard.list(.myPlan).instantiateViewController(withIdentifier: MyPlanVC.className)
        return myPlanVC
    }
  }
}
