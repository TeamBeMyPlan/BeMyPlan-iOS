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
  @IBOutlet var tabbarStackContainerView: UIView!
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setContainerView()
    setTabIcon()
    addObservers()
  }
  override func viewWillAppear(_ animated: Bool) {
    showTabbar()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    hideTabbar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    showContainerView()
//    self.navigationController?.viewControllers.removeAll()

//    navigationController?.interactivePopGestureRecognizer?.delegate = nil
//    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)

  }
  

  
  open override func didMove(toParent parent: UIViewController?) {
    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)
  }
  
  
  // MARK: - Constraint Part
  
  @IBOutlet var tabContainerLeading: NSLayoutConstraint!
  
  // MARK: - Custom Method Part
  private func setContainerView(){
    for (index,item) in containerViewList.enumerated(){
      item.alpha = 0
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
  
  private func showContainerView(){
    UIView.animate(withDuration: 0.3) { [unowned self] in
      self.containerViewList[self.clickedIndex.rawValue].alpha = 1
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
  
  private func showTabbar(){
    UIView.animate(withDuration: 0.7) {
      self.tabbarStackContainerView.alpha = 1
    }
  }
  
  private func hideTabbar(){
    UIView.animate(withDuration: 0.7) {
      self.tabbarStackContainerView.alpha = 0
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
    showContainerView()
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
    if index != self.clickedIndex{
      UIView.animate(withDuration: 0.25) {
        self.containerViewList[self.clickedIndex.rawValue].alpha = 0
      }completion: { _ in
        self.clickedIndex = index
      }
    }
  }
}


extension BaseVC : UIGestureRecognizerDelegate {
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return otherGestureRecognizer is PanDirectionGestureRecognizer
  }

}
