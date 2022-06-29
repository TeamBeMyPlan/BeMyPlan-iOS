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

  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.getRecentlyListData()
    self.getSuggestListData()
  }
  
  override func viewDidAppear(_ animated: Bool) {

  }
  
  override func viewDidLayoutSubviews() {
    naviView.layer.applyShadow(color: UIColor(displayP3Red: 0.796, green: 0.796, blue: 0.796, alpha: 0.25), alpha: 1, x: 1, y: 4, blur: 8, spread: 1)
  }
  
  private func getRecentlyListData(){
    BaseService.default.getHomeRecentSortList { result in
      result.success { [weak self] list in
        guard let list = list else { return }
        print("@@@getRecentlyListData@@@@@@@@@@@")
        print(list.contents.first?.title)
        print(list.contents.first?.thumbnailURL)
        self?.mainListView.mainListDataList = list.contents
      }.catch { error in
        self.postObserverAction(.showNetworkError,object: nil)
      }
    }
  }
  
  private func getSuggestListData(){
    BaseService.default.getHomeBemyPlanSortList{ result in
      result.success { [weak self] list in
        guard let list = list else { return }
        print("@@@getSuggestListData@@@@@@@@@@@")
        print(list.contents.first?.title)
        self?.mainEditorListView.mainListDataList = list.contents
      }.catch { error in
        self.postObserverAction(.showNetworkError,object: nil)
      }
    }
  }
  

}
