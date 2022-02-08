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
    //    setDummyData()
//    getListData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    //    navigationController?.interactivePopGestureRecognizer?.delegate = self
    //    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
  
  override func viewDidLayoutSubviews() {
    naviView.layer.applyShadow(color: UIColor(displayP3Red: 0.796, green: 0.796, blue: 0.796, alpha: 0.25), alpha: 1, x: 1, y: 4, blur: 8, spread: 1)
  }
  
  // MARK: - Custom Method Part

  //  func setDummyData(){
  //    let a = [
  //      MainListData(image: "mainlist1", title: "푸드파이터들을 위한 찐먹킷리스트투어"),
  //      MainListData(image: "mainlist2", title: "부모님과 함께하는 3박4일 제주 서부 여행")
  //    ]
  //
  //    let b = [
  //      MainListData(image: "mainlist3", title: "워케이션을 위한 카페투어"),
  //      MainListData(image: "mainlist4", title: "27년 제주 토박이의 히든 플레이스 투어")
  //    ]
  //
  //    mainListView.mainListDataList = a
  //    mainEditorListView.mainListDataList = b
  //  }
}
