//
//  NewPlanPreviewVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/06/28.
//

import UIKit
import RxSwift
import StoreKit

class NewPlanPreviewVC: UIViewController {
  // MARK: - Vars & Lets Part
  private var planPurchsaeItem = SKProduct()
  private var purhcaseProduct = PlanPurchaseItem()
  internal var planID: Int = 2
  private var contentList: [[NewPlanPreviewViewCase]] = [
    [.topHeader, .creator, .recommendReason],
    [.mainContents, .purhcaseGuide,
     .suggestList, .usingTerm,
     .purhcaseTerm, .question ,.footer]
  ]
  private var creatorCellViewModel: NewPlanPreviewCreatorViewModel?
  private var headerCellViewModel: NewPlanPreviewHeaderViewModel?
  private var mainContentCellViewModel: NewPlanPreviewMainContentViewModel?
  private var suggestCellViewModel: NewPlanPreviewSuggestViewModel?
  private var termFoldState: [Bool] = [false,true,true]
  
  private var mainContentCellYPos: CGFloat = 0
  private var purchaseGuideCellYPos: CGFloat = 0
  private var recommendCellYPos: CGFloat = 0
  private var isPurhcased: Bool = false
  
  // MARK: - UI Component Part
  @IBOutlet var topNavibar: NewPlanPreviewNaviBar!
  @IBOutlet var mainContentTV: UITableView!
  @IBOutlet var bottomCTAButton: UIButton!
  @IBOutlet var bottomScrapButton: UIButton!
  private let layer = UIView()
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    registerCell()
    setDelegate()
    setTableView()
    setUI()
    bindButtonAction()
    addObserver()
    topNavibar.backgroundView.alpha = 0
    fetchPlanHeaderData()
    fetchCreatorData()
    fetchPlanPreviewDetail()
    fetchPlanSuggestList()
    
    if let sessionID = UserDefaults.standard.string(forKey: UserDefaultKey.sessionID) {
      print("SESSION ID =>",sessionID)
    }
  
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
    mainContentTV.allowsSelection = false
    mainContentTV.showsVerticalScrollIndicator = false
    
    if #available(iOS 15.0, *) {
      mainContentTV.sectionHeaderTopPadding = 0.0
    }
  }
  
  private func initPurchaseProduct() {

    PlanPurchaseItem.productID = "bemyplan.purchase.test3"
    PlanPurchaseItem.iapService.getProducts { [weak self] success, products in
        guard let self = self else { return }
      
        if success,
           self.headerCellViewModel != nil,
            let products = products {
          DispatchQueue.main.async {

            self.planPurchsaeItem = products.first!
            self.headerCellViewModel!.price = self.makePrice(self.planPurchsaeItem.price.stringValue)
            self.mainContentTV.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
          }
        }
    }
    
    let purhcaseState = PlanPurchaseItem.iapService.isProductPurchased(PlanPurchaseItem.productID)
    print("PURCHASE ___",purhcaseState)
    
    let buttonTitle = purhcaseState ? "전체 여행 코스 보러가기" : "구매하기"
    bottomCTAButton.setTitle(buttonTitle, for: .normal)
  }
  
  // 인앱 결제 버튼 눌렀을 때
  private func purchaseActionStart() {
    PlanPurchaseItem.iapService.buyProduct(planPurchsaeItem)
  }
  
  private func pushDetailView() {
    
  }
  
  private func registerCell() {
    NewPlanPreviewHeader.register(target: mainContentTV)
    NewPlanPreviewCreator.register(target: mainContentTV)
    NewPlanPreviewMainContents.register(target: mainContentTV)
    NewPlanPreviewPurchaseGuide.register(target: mainContentTV)
    NewPlanPreviewSuggestList.register(target: mainContentTV)
    NewPlanPreviewTermsCell.register(target: mainContentTV)
    NewPlanPreviewMockCell.register(target: mainContentTV)
  }
  
  private func setUI() {
    bottomCTAButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    bottomCTAButton.layer.cornerRadius = 4
    layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
  }
  
  private func bindButtonAction() {
    bottomCTAButton.press {
      self.isPurhcased ? self.pushDetailView() : self.purchaseActionStart()
    }
  }
  
  private func addObserver() {
    addObserverAction(.IAPServicePurchaseNotification) { noti in
        guard
            let productID = noti.object as? String,
            self.planPurchsaeItem.productIdentifier == productID
          else { return }
      self.makeAlert(content: "구매가 완료되었습니다.")
      print("구매 성공")
    }
    
    addObserverAction(.purchaseComplete) { noti in
      if let data = noti.object as? String {
        print("영수증 번호 ===> ",data)
        // TODO: - 구매 post 요청 보내기
        // TODO: - post 성공하면 영수증 검증 보내기
        // TODO: - 성공하면 구매 확정 post 보내기 하면 끝!
      }
    }
  
    addObserverAction(.informationButtonClicked) { _ in
      let informationVC = ModuleFactory.resolve().makeSummaryHelper()
      self.addBlackLayer()
      self.present(informationVC, animated: true)
      
      informationVC.screenDismissed = {
        self.removeBlackLayer()
      }
    }
    
    addObserverAction(.newPlanPreviewTermFoldClicked) { noti in
      if let type = noti.object as? NewPlanPreviewViewCase {
        if type == .usingTerm { self.termFoldState[0].toggle() }
        else if type == .purhcaseTerm { self.termFoldState[1].toggle() }
        else if type == .question { self.termFoldState[2].toggle() }
        self.mainContentTV.reloadData()
      }
    }

    addObserverAction(.newPlanPreviewSectionHeaderClicked) { noti in
      if let index = noti.object as? Int {
        self.mainContentTV.scrollToRow(at: IndexPath.init(row: index, section: 1), at: .top, animated: true)
      }
    }
  }
  
  private func addBlackLayer() {
    layer.alpha = 0
    view.addSubview(layer)
    
    layer.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
      self.layer.alpha = 0.6
    }
  }
  
  private func removeBlackLayer() {
    UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
      self.layer.alpha = 0
    } completion: { _ in
      self.layer.removeFromSuperview()
    }
  }
}

extension NewPlanPreviewVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let heightCalculator = NewPlanPreviewHeightCalculator.shared
    if indexPath.section == 0 {
      switch(indexPath.row) {
        case 0: return screenWidth * (472/375) + 310
        case 1: return heightCalculator.calculateCreatorCellHeight(text: creatorCellViewModel?.creatorIntroduce)
        default : return 242
      }
    } else {
      switch(indexPath.row) {
        case 0:
          guard let mainContentCellViewModel = mainContentCellViewModel else { return 0 }
          let textList = mainContentCellViewModel.contentList.map { $0.contents }
          return heightCalculator.calculateMainCellHeight(textList: textList) + 121
        case 1:     return 620
        case 2:     return screenWidth * (380/375)
        case 3: return termFoldState[indexPath.row - 3] ? 56 : 56 + screenWidth * (108/375)
        case 4: return termFoldState[indexPath.row - 3] ? 56 : 56 + screenWidth * (208/375)
        case 5: return termFoldState[indexPath.row - 3] ? 56 : 56 + screenWidth * (68/375)
        default: return 171
      }
    }
  }
  
}

extension NewPlanPreviewVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    if section == 1 {
      let header = NewPlanPreviewSectionHeader()
      return header
    } else {
      return UIView()
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 1 {
      return 46 + 90
    } else {
      return .leastNonzeroMagnitude
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = indexPath.section
    let row = indexPath.row
    switch(contentList[section][row]) {
      case .topHeader:
        print("TOP HEADER")
        
        guard let header = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewHeader.className,
                                                         for: indexPath) as? NewPlanPreviewHeader
        else { return UITableViewCell() }
        guard let viewModel = self.headerCellViewModel else { return UITableViewCell() }
        
        print("HEADERVIEW",viewModel.price)
        header.viewModel = viewModel
        header.setHeaderData()
        return header
        
      case .creator:
        guard let creatorCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewCreator.className,
                                                              for: indexPath) as? NewPlanPreviewCreator
        else { return UITableViewCell() }
        
        guard let viewModel = self.creatorCellViewModel else {
          
          return UITableViewCell() }
        creatorCell.viewModel = viewModel
        return creatorCell
      case .recommendReason:
        guard let mockCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewMockCell.className,
                                                           for: indexPath) as? NewPlanPreviewMockCell else { return UITableViewCell() }
        let view = NewPlanPreviewRecommendReason()
        
        mockCell.addSubview(view)
        view.snp.makeConstraints { make in
          make.edges.equalToSuperview()
        }
        return mockCell
        
      case .mainContents:
        
        guard let mainContentCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewMainContents.className,
                                                                  for: indexPath) as? NewPlanPreviewMainContents
        else { return UITableViewCell() }
        guard let viewModel = self.mainContentCellViewModel else { return UITableViewCell() }
        mainContentCell.viewModel = viewModel
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
        let viewModel = self.suggestCellViewModel
        suggestCell.viewModel = viewModel
        return suggestCell
        
      case .usingTerm:
        guard let termCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewTermsCell.className,
                                                           for: indexPath) as? NewPlanPreviewTermsCell
        else { return UITableViewCell() }
        let viewModel = TermDataModel(title: "이용약관", content: "")
        termCell.viewModel = viewModel
        termCell.setFoldState(isFold: termFoldState[0])
        termCell.setTermType(.usingTerm)
        return termCell
        
      case .purhcaseTerm:
        guard let termCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewTermsCell.className,
                                                           for: indexPath) as? NewPlanPreviewTermsCell
        else { return UITableViewCell() }
        let viewModel = TermDataModel(title: "결제안내", content: "이용약관")
        termCell.viewModel = viewModel
        termCell.setFoldState(isFold: termFoldState[1])
        termCell.setTermType(.purhcaseTerm)
        
        return termCell
        
      case .question:
        guard let termCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewTermsCell.className,
                                                           for: indexPath) as? NewPlanPreviewTermsCell
        else { return UITableViewCell() }
        let viewModel = TermDataModel(title: "문의사항", content: "이용약관")
        termCell.viewModel = viewModel
        termCell.setFoldState(isFold: termFoldState[2])
        termCell.setTermType(.question)
        
        return termCell
        
      case .footer:
        guard let mockCell = tableView.dequeueReusableCell(withIdentifier: NewPlanPreviewMockCell.className,
                                                           for: indexPath) as? NewPlanPreviewMockCell else { return UITableViewCell() }
        let view = NewPlanPreviewLogoFooterView()
        mockCell.addSubview(view)
        view.snp.makeConstraints { make in
          make.edges.equalToSuperview()
        }
        return mockCell
      default: return UITableViewCell()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      guard self.headerCellViewModel != nil
              && self.headerCellViewModel != nil else {
        return 0
      }
      return contentList[0].count
    } else {
      guard self.mainContentCellViewModel != nil else { return 0 }
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
  case usingTerm
  case purhcaseTerm
  case question
  case footer
}

extension NewPlanPreviewVC : UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let imageHeaderHeight: CGFloat = screenWidth * (472/375) - 80
    let yPos = scrollView.contentOffset.y

    let posY = scrollView.contentOffset.y
    if posY < imageHeaderHeight {
      topNavibar.backgroundView.alpha = posY / imageHeaderHeight
      
    } else {
      topNavibar.backgroundView.alpha = 1
    }
    
    switch(yPos + 90 + 50) {
      case 0 ..< purchaseGuideCellYPos :
        postObserverAction(.newPlanPreviewScrollIndexChanged, object: 0)

      case purchaseGuideCellYPos ..< recommendCellYPos :
        postObserverAction(.newPlanPreviewScrollIndexChanged, object: 1)

      case recommendCellYPos ... 10000 :
        postObserverAction(.newPlanPreviewScrollIndexChanged, object: 2)

      default: break
    }
  }
}

extension NewPlanPreviewVC {
  private func fetchCreatorData() {
    guard self.planID != 0 else { return }
    BaseService.default.fetchNewPlanPreviewCreator(idx: self.planID) { result in
      result.success { entity in
        guard let entity = entity else { return }
        self.creatorCellViewModel = NewPlanPreviewCreatorViewModel(profileImgURL: "https://picsum.photos/200",
                                                                   authorName: entity.nickname,
                                                                   authorDescription: "제주를 브랜딩하는 스냅 작가",
                                                                   creatorIntroduce: entity.description,
                                                                   authorIdx: entity.userID)
        self.mainContentTV.reloadData()
        
      }.catch { err in
        print("크리에이터 데이터 조회 실패")
      }
    }
  }
  
  private func fetchPlanHeaderData() {
    BaseService.default.fetchNewPlanPreviewCourse(idx: self.planID) { result in
      result.success { entity in
        guard let entity = entity else { return }
        self.initPurchaseProduct()

        let iconData = PlanPreview.IconData(theme: self.makeThemeString(entity.theme),
                                            spotCount: "\(entity.spotCount)",
                                            restaurantCount: "\(entity.restaurantCount)",
                                            dayCount: "\(entity.totalDay)",
                                            peopleCase: self.makePartnerString(entity.travelPartner),
                                            budget: self.makeBudget(entity.budget.amount),
                                            transport: self.makeTransport(entity.travelMobility),
                                            month: "\(entity.month)")
        
        self.headerCellViewModel = NewPlanPreviewHeaderViewModel(imgList: entity.thumbnail,
                                                                 title: entity.title,
                                                                 address: self.makeRegionString(entity.region),
                                                                 hashtag: entity.hashtag,
                                                                 price: self.makePrice(String(entity.price)),
                                                                 iconData: iconData)
        self.mainContentTV.reloadData()
        
      }.catch { err in
        print("미리보기 헤더 데이터 조회 실패")
      }
    }
  }
  
  private func fetchPlanPreviewDetail() {
    BaseService.default.fetchNewPlanPreviewDetail(idx: self.planID) { result in
      result.success { entity in
        guard let entity = entity else { return }
        let contentList = entity.previewContents.map { content -> NewPlanMainContentsCellViewModel in
          return NewPlanMainContentsCellViewModel(imgURLs: content.images,
                                                  contents: content.previewContentDescription)
        }
        self.mainContentCellViewModel = NewPlanPreviewMainContentViewModel(contentList: contentList)
        self.mainContentTV.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          print(self.mainContentTV.rectForRow(at: IndexPath.init(row: 0, section: 0)).minY)
          print(self.mainContentTV.rectForRow(at: IndexPath.init(row: 1, section: 0)).minY)
          print(self.mainContentTV.rectForRow(at: IndexPath.init(row: 2, section: 0)).minY)
          print(self.mainContentTV.rectForRow(at: IndexPath.init(row: 0, section: 1)).minY)
          print(self.mainContentTV.rectForRow(at: IndexPath.init(row: 1, section: 1)).minY)
          print(self.mainContentTV.rectForRow(at: IndexPath.init(row: 2, section: 1)).minY)

          self.mainContentCellYPos = self.mainContentTV.rectForRow(at: IndexPath.init(row: 0, section: 1)).minY
          self.purchaseGuideCellYPos = self.mainContentTV.rectForRow(at: IndexPath.init(row: 1, section: 1)).minY
          self.recommendCellYPos = self.mainContentTV.rectForRow(at: IndexPath.init(row: 2, section: 1)).minY
        }

      }.catch { _ in
        print("미리보기 상세정보 조회 실패")
      }
    }
  }
  
  private func fetchPlanSuggestList() {
    BaseService.default.fethcNewPlanPreviewRecommend(region: "JEJU") { result in
      result.success { entity in
        guard let entity = entity else { return }
        let suggestCellViewModel = entity.map { entity -> NewPlanPreviewSuggestCellViewModel in
          return NewPlanPreviewSuggestCellViewModel.init(title: entity.title,
                                                         address: self.makeRegionString(entity.region.rawValue),
                                                         imgURL: entity.thumbnailURL,
                                                         planID: entity.planID)
        }
        let viewModel = NewPlanPreviewSuggestViewModel(list: suggestCellViewModel)
        self.suggestCellViewModel = viewModel
        self.mainContentTV.reloadData()
      }.catch { err in
        print("추천 리스트 조회 실패")
      }
    }
  }
}

extension NewPlanPreviewVC {
  private func makePrice(_ price: String) -> String {
    guard let price = Int(price) else { return "" }
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    let formattedNumber = numberFormatter.string(from: NSNumber(value: price))
    return formattedNumber ?? ""
  }
  
  private func makeRegionString(_ region: String) -> String {
    switch(region) {
      case "JEJUALL": return "제주시"
      default:        return ""
    }
  }
  
  private func makeThemeString(_ theme: String) -> String {
    switch(theme) {
      case "HEALING" : return "힐링"
      default        : return "미정"
    }
  }
  
  private func makePartnerString(_ partnerCase: String) -> String {
    switch(partnerCase) {
      case "FRIEND" : return "친구"
      default       : return "미정"
    }
  }
  
  private func makeTransport(_ transportCase: String) -> String {
    switch(transportCase) {
      case "CAR"   : return "자동차"
      default      : return "미정"
    }
  }
  
  private func makeBudget(_ budget: Int) -> String {
    let amount = budget / 10000
    return "\(amount)만원"
  }
  
}
