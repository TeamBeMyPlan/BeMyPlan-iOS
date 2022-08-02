//
//  ImageLiterals.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit

struct ImageLiterals{
  
  struct TabBar{
    static let homeIcon = UIImage(named: "icon_home")!
    static let homeIconSelected = UIImage(named: "icon_home_selected")!
    
    static let travelSpotIcon = UIImage(named: "icon_list")!
    static let travelSpotIconSelected = UIImage(named: "icon_list_selected")!
    
    static let scrapIcon = UIImage(named: "icon_scrab")!
    static let scrapIconSelected = UIImage(named: "icon_scrab_selected")!
    
    static let myPlanIcon = UIImage(named: "icon_myplan")!
    static let myPlanIconSelected = UIImage(named: "icon_myplan_selected")!
  }
	
	struct Onboarding {
		static let previewImage1 = UIImage(named: "img_onboarding_01")!
		static let previewImage2 = UIImage(named: "img_onboarding_02")!
		static let previewImage3 = UIImage(named: "img_onboarding_03")!
		
		static let pageControlDot1 = UIImage(named: "dots_1")!
		static let pageControlDot2 = UIImage(named: "dots_2")!
		static let pageControlDot3 = UIImage(named: "dots_3")!
	}
	
	struct Preview{
		static let scrabIcon = UIImage(named: "icon_scrab")!
		static let scrabIconSelected = UIImage(named: "icon_scrab_selected")!
		static let arrowUpside = UIImage(named: "dropdown_active")!
		static let arrowDownSide = UIImage(named: "dropdown_inactive")
	}
	
	struct PlanDetail{
		static let walkIcon = UIImage(named: "icn_walk")!
		static let busIcon = UIImage(named: "icn_commute")!
		static let carIcon = UIImage(named: "icn_car")!
		static let foldIcon = UIImage(named : "icn_more")!
		static let moreIcon = UIImage(named: "icn_fold")!
		static let mapSelectIcon = UIImage(named: "icn_mainpin_select")!
		static let mapUnselectIcon = UIImage(named: "icn_subpin_unselect")!
		static let mapSelectIconClicked = UIImage(named: "icn_mainpin_clicked")!
		static let foldDetailIcon = UIImage(named: "ic_detail_fold")!
		static let unfoldDetailIocn = UIImage(named: "ic_detail_unfold")!
	}
  struct Components{
		static let applogo = UIImage(named: "applogo")!
  }
	struct SignUp{
		static let checkoffIcon = UIImage(named: "check_off_silver")
		static let checkonIcon = UIImage(named: "check_on_blue")
	}
	
	struct Scrap{
		static let scrapIconNotFilled = UIImage(named: "icnNotScrapWhite")!
		static let scrapFIconFilled = UIImage(named: "icnScrapWhite")!
	}
}
