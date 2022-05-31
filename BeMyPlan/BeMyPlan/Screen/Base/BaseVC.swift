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
  var isFirstload = true
  var clickedIndex : TabList = .home{
    didSet{
      runTabClickAction()
      setTabLog()
    }
  }
  var currentTabList : [TabList] = []
  let factory: ModuleFactoryProtocol = ModuleFactory.resolve()
  
  // MARK: - UI Component Part
  
  @IBOutlet var containerView: BaseContainerView!
//  @IBOutlet var containerViewList: [BaseContainerView]!
  @IBOutlet var tabIconList: [TabBarIconView]!
  @IBOutlet var tabbarStackContainerView: UIView!
  @IBOutlet var tabbarBottomConstraint: NSLayoutConstraint! // -34
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setContainerView()
    setTabIcon()
    addObservers()
  }
  override func viewWillAppear(_ animated: Bool) {
    if isFirstload{
      isFirstload = false
    }else{
      showTabbar()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    hideTabbar()
  }
  override func viewDidLayoutSubviews() {
    showContainerView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
//    self.navigationController?.viewControllers.removeAll()

    navigationController?.interactivePopGestureRecognizer?.delegate = nil
    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)

  }
  
  open override func didMove(toParent parent: UIViewController?) {
    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)
  }
  
  // MARK: - Constraint Part
  
  @IBOutlet var tabContainerLeading: NSLayoutConstraint!
  
  // MARK: - Custom Method Part
  
  private func setContainerView(){
    if !currentTabList.contains(clickedIndex){
      let vc = containerView.getTabVC(clickedIndex)
      vc.view.translatesAutoresizingMaskIntoConstraints = false
      self.addChild(vc)
      containerView.addSubview(vc.view)
      vc.view.snp.makeConstraints {
        $0.top.leading.bottom.trailing.equalToSuperview()
      }
      vc.didMove(toParent: self)
      currentTabList.append(clickedIndex)
    }else{
      if let index = currentTabList.firstIndex(of: clickedIndex){
        let containerVC = containerView.subviews[index+1]
        containerView.bringSubviewToFront(containerVC)
        currentTabList.remove(at: index)
        currentTabList.append(clickedIndex)
      }
    }
  }
  
  private func setTabLog(){
    let tabSource: LogEventType.TabSource
    switch(clickedIndex){
      case .home: tabSource = .home
      case .travelSpot: tabSource = .travelSpot
      case .scrap: tabSource = .scrap
      case .myPlan: tabSource = .myPlan
    }
    AppLog.log(at: FirebaseAnalyticsProvider.self, .clickTab(source: tabSource))
  }
  private func showContainerView(){
    self.containerView.alpha = 1
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
    self.tabbarBottomConstraint.constant = -34
    UIView.animate(withDuration: 0.8) {
      self.view.layoutIfNeeded()
    }
  }
  
  private func hideTabbar(){
    self.tabbarBottomConstraint.constant = -123
    UIView.animate(withDuration: 0.8) {
      self.view.layoutIfNeeded()
    }
  }

  private func runTabClickAction(){
    setTabIcon(isFirstRun: false)
    showContainerView()
    setContainerView()
  }
  
  private func makeTabList(index : Int) -> TabList{
    switch(index){
      case 0: return .home
      case 1: return .travelSpot
      case 2: return .scrap
      default : return .myPlan
    }
  }
}

// MARK: - Extension Part
extension BaseVC : TabBarDelegate{
  func tabClicked(index: TabList) {
    if index != self.clickedIndex{
      UIView.animate(withDuration: 0.25) {
        self.containerView.alpha = 1
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
