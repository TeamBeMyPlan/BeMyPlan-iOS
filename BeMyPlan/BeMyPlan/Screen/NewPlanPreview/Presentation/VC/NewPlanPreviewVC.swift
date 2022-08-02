//
//  NewPlanPreviewVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit
import RxSwift

class NewPlanPreviewVC: UIViewController {
  // MARK: - Vars & Lets Part
  
  private let contentList: [[NewPlanPreviewViewCase]] = [
    [.topHeader, .creator],
    [.mainContents, .purhcaseGuide,
     .suggestList, .terms, .footer]
  ]


  // MARK: - UI Component Part
  @IBOutlet var topNavibar: NewPlanPreviewNaviBar!
  @IBOutlet var mainContentTV: UITableView!
  @IBOutlet var bottomCTAButton: UIButton!
  @IBOutlet var bottomScrapButton: UIButton!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    registerCell()
    setDelegate()
    setTableView()
    topNavibar.backgroundView.alpha = 0
  }
  
}

extension NewPlanPreviewVC {
  private func setDelegate() {
    mainContentTV.delegate = self
    mainContentTV.dataSource = self
  }
  
  private func setTableView() {
    mainContentTV.separatorStyle = .none
    mainContentTV.contentInsetAdjustmentBehavior = .never
    mainContentTV.automaticallyAdjustsScrollIndicatorInsets = false
    
    if #available(iOS 15.0, *) {
      mainContentTV.sectionHeaderTopPadding = 0.0
    }
  }
  
  private func registerCell() {
    NewPlanPreviewHeader.register(target: mainContentTV)
    NewPlanPreviewCreator.register(target: mainContentTV)
    NewPlanPreviewMainContents.register(target: mainContentTV)
    NewPlanPreviewPurchaseGuide.register(target: mainContentTV)
    NewPlanPreviewSuggestList.register(target: mainContentTV)
    NewPlanPreviewTermsCell.register(target: mainContentTV)
  }
}

extension NewPlanPreviewVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      switch(indexPath.row) {
        case 0: return screenWidth * (472/375) + 288
        case 1: return 429
        default : return 0
      }
    } else {
      switch(indexPath.row) {
        case 0: return 1200
        case 1: return 600
        case 2: return screenWidth * (350/375)
        case 3: return 56
        default: return 0
      }
    }
  }
  
}

extension NewPlanPreviewVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    if section == 1 {
      let a = UIView()
      a.backgroundColor = .yellow
      return a
    } else {
      return UIView()
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 1 {
      return 64
    } else {
      return .leastNonzeroMagnitude
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    if section == 0 {
      return NewPlanPreviewRecommendReason()
    } else {
      return NewPlanPreviewLogoFooterView()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if section == 1 {
      return 171
    } else {
      return 292
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = indexPath.section
    let row = indexPath.row
    switch(contentList[section][row]) {
      case .topHeader:
        guard let header = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewHeader.className,
                                                         for: indexPath) as? NewPlanPreviewHeader
        else { return UITableViewCell() }
        let headerViewModel = NewPlanPreviewHeaderViewModel(imgList: ["https://picsum.photos/600","https://picsum.photos/600"],
          title: "감성을 느낄 수 있는 힐링여행",
                                                            address: "제주 동부",
                                                            hashtag: ["해시태그","해시태그","해시태그"],
                                                            price: "1,000",
                                                            iconData: .init(theme: "힐링",
                                                                            spotCount: "32곳",
                                                                            restaurantCount: "12곳",
                                                                            dayCount: "5일",
                                                                            peopleCase: "친구",
                                                                            budget: "45만원",
                                                                            transport: "버스",
                                                                            month: "8월"))
        header.viewModel = headerViewModel
        return header
        
      case .creator:
        guard let creatorCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewCreator.className,
                                                         for: indexPath) as? NewPlanPreviewCreator
        else { return UITableViewCell() }
        let creatorViewModel = NewPlanPreviewCreatorViewModel(profileImgURL: "https://picsum.photos/200",
                                                              authorName: "크리에이터 이름",
                                                              authorDescription: "제주를 브랜딩하는 스냅 작가",
                                                              creatorIntroduce: "안녕하세요 ~")
        creatorCell.viewModel = creatorViewModel
        return creatorCell
        
      case .mainContents:
        
        guard let mainContentCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewMainContents.className,
                                                         for: indexPath) as? NewPlanPreviewMainContents
        else { return UITableViewCell() }
        let mainContentViewModel = NewPlanPreviewMainContentViewModel.init(contentList: [.init(imgURLs: ["https://picsum.photos/200"], contents: "안녕하세요~")])
        mainContentCell.viewModel = mainContentViewModel
        return mainContentCell
        
      case .purhcaseGuide:
        guard let purchaseGuideCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewPurchaseGuide.className,
                                                         for: indexPath) as? NewPlanPreviewPurchaseGuide
        else { return UITableViewCell() }
        let viewModel = NewPlanPreviewPurchaseGuideViewModel(list: [.init(title: "장소를 표시한 지도", subtitle: "여행 일정에 포함된 모든 장소가 지도에 다 나와있어요"),
                                                                    .init(title: "일자별 여행 코스", subtitle: "일차별 일정을 한눈에 살펴보세요"),
                                                                    .init(title: "더 많은 양의 사진과 글", subtitle: "구매 후 더 풍부한 사진과 정보를 만나보세요"),
                                                                    .init(title: "솔직 후기", subtitle: "여행 플레이스의 장점과 단점을 알아보세요"),
                                                                    .init(title: "가본 사람만 알 수 있는 꿀팁", subtitle: "검색으로 쉽게 안 나오는 팁들읖 챙겨가세요"),
                                                                    .init(title: "다음 장소로 이동할 때의 교통편", subtitle: "어떻게 이동했고, 몇 분이 걸렸는지 확인해보세요")
                                                                   ])
        
        purchaseGuideCell.viewModel = viewModel
        return purchaseGuideCell
        
      case .suggestList:
        guard let suggestCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewSuggestList.className,
                                                         for: indexPath) as? NewPlanPreviewSuggestList
        else { return UITableViewCell() }
        let viewModel = NewPlanPreviewSuggestViewModel(list: [.init(title: "워케이션을 위한 카페투어",
                                                                    address: "제주 동부",
                                                                    imgURL: "https://picsum.photos/200")])
        suggestCell.viewModel = viewModel
        return suggestCell
        
      case .terms:
        guard let termCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewTermsCell.className,
                                                         for: indexPath) as? NewPlanPreviewTermsCell
        else { return UITableViewCell() }
        let viewModel = TermDataModel(title: "이용약관", content: "이용약관")
        termCell.viewModel = viewModel
        return termCell
        
      default: return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return contentList[0].count
    } else {
      return contentList[1].count
    }
  }
}

enum NewPlanPreviewViewCase: Int{
  case topHeader
  case creator
  case recommendReason
  case menuBar
  case mainContents
  case purhcaseGuide
  case suggestList
  case terms
  case footer
}
