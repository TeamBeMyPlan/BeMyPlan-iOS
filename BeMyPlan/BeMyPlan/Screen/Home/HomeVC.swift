//
//  HomeVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit

class HomeVC: UIViewController, UIGestureRecognizerDelegate {
  
  // MARK: - UI Component Part
  //  let a = MainCardView()
  @IBOutlet var naviView: UIView!
  
  @IBOutlet var naviBarTopConstraint: NSLayoutConstraint!{
    didSet {
      naviBarTopConstraint.constant = calculateTopInset()
    }
  }
  @IBOutlet var mainCardView: MainCardView!
  @IBOutlet var mainListView: MainListView! {
    didSet {
      mainListView.type = .recently
    }
  }
  @IBOutlet var mainEditorListView: MainListView! {
    didSet {
      mainEditorListView.type = .editorRecommend
    }
  }
  
  @IBOutlet var mainCardViewHeightConstraint: NSLayoutConstraint! {
    didSet {
      let screenWidth = UIScreen.main.bounds.width
      let cellWidth = screenWidth * (327/375)
      let cellHeight = cellWidth * (435/327)
      mainCardViewHeightConstraint.constant = cellHeight + 150
    }
  }
  
  @IBOutlet var mainListViewHeightConstraint: NSLayoutConstraint! {
    didSet {
      let screenWidth = UIScreen.main.bounds.width
      let cellWidth = screenWidth * (160/375)
      let cellHeight = cellWidth * (208/160)
      
      mainListViewHeightConstraint.constant = cellHeight + 75
    }
  }
  @IBOutlet var mainEditorViewHeightConstraint: NSLayoutConstraint! {
    didSet {
      let screenWidth = UIScreen.main.bounds.width
      let cellWidth = screenWidth * (160/375)
      let cellHeight = cellWidth * (208/160)
      mainEditorViewHeightConstraint.constant = cellHeight + 75
    }
  }
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    AppLog.log(at: FirebaseAnalyticsProvider.self, .view_home)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    postObserverAction(.viewWillAppearInHome)
  }
  
  override func viewDidAppear(_ animated: Bool) {

  }
  
  override func viewDidLayoutSubviews() {
    naviView.layer.applyShadow(color: UIColor(displayP3Red: 0.796, green: 0.796, blue: 0.796, alpha: 0.25), alpha: 1, x: 1, y: 4, blur: 8, spread: 1)
  }
  

}
