//
//  BaseVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/06.
//

import UIKit
import SnapKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class BaseVC: UIViewController {

  // MARK: - Vars & Lets Part
  
  var clickedIndex : TabList = .home{
    didSet{
      runTabClickAction()
    }
  }

  // MARK: - UI Component Part
  
  @IBOutlet var containerViewList: [BaseContainerView]!
  @IBOutlet var tabIconList: [TabBarIconView]!
  
  // MARK: - Life Cycle Part
  
    override func viewDidLoad() {
        super.viewDidLoad()
      setContainerView()
      setTabIcon()
    }
  
  override func viewDidAppear(_ animated: Bool) {
    navigationController?.interactivePopGestureRecognizer?.delegate = nil
    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
  }
    
  // MARK: - Constraint Part

  @IBOutlet var tabContainerLeading: NSLayoutConstraint!
  
  // MARK: - Custom Method Part
  private func setContainerView(){
    for (index,item) in containerViewList.enumerated(){
      let vc = item.getTabVC(makeTabList(index: index))
      vc.view.translatesAutoresizingMaskIntoConstraints = false
      self.addChild(vc)
      item.addSubview(vc.view)
      vc.view.snp.makeConstraints {
        $0.top.leading.bottom.trailing.equalToSuperview()
      }
      vc.didMove(toParent: self)
    }
  }
  
  private func setTabIcon(isFirstRun : Bool = true){
    for (index,item) in tabIconList.enumerated(){
      if isFirstRun{
        item.delegate = self
      }
      item.setTab(tab: makeTabList(index: index),
                  isClicked: makeTabList(index: index) == clickedIndex)
    }
  }
  
  private func setContainerLeading(){
    let leading : CGFloat
    switch(clickedIndex){
      case .home : leading = 0
      case .travelSpot : leading = screenWidth
      case .scrap : leading = screenWidth * 2
      case .myPlan : leading = screenWidth * 3
    }
    tabContainerLeading.constant = leading * (-1)
    self.view.layoutIfNeeded()
  }
  
  private func runTabClickAction(){
    setTabIcon(isFirstRun: false)
    setContainerLeading()
  }
  
  private func makeTabList(index : Int) -> TabList{
    switch(index){
      case 0: return .home
      case 1: return .travelSpot
      case 2: return .scrap
      default : return .myPlan
    }
  }

  // MARK: - @objc Function Part

}
// MARK: - Extension Part
extension BaseVC : TabBarDelegate{
  func tabClicked(index: TabList) {
    clickedIndex = index
  }
}
