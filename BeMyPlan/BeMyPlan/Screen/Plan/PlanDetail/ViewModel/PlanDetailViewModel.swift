//
//  PlanDetailViewModel.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/02/22.
//

import Foundation
import Moya

protocol PlanDetailViewModelType: ViewModelType {
  
  // Inputs
  
  func viewDidLoad()
  func currentDayChanged(day: Int)
  func bottomContainerFoldChanged()
  func summaryFoldChanged(fold: Bool)
  func clickPhotos(urls: [String])
  
  // Outputs
  var didFetchDataStart: (() -> Void)? { get set }
  var didFetchDataComplete: (() -> Void)? { get set }
  var networkError: (() -> Void)? { get set }
  var unexpectedError: (() -> Void)? { get set }
  var didUpdateWriterViewModel: ((PlanDetailWriterViewModel) -> Void)? { get set }
  var didUpdateSelectDayViewModel: ((PlanDetailSelectDayViewModel) -> Void)? { get set }
  var didUpdateSummaryCellViewModel: ((PlanDetailSummaryViewModel) -> Void)? { get set }
  var didUpdateinformationCellViewModel: (([PlanDetailInformationViewModel]) -> Void)? { get set }
  var didUpdateWriterBlockHeight: ((CGFloat) -> Void)? { get set }
  var showImageSlide: (([ImageForSlide]) -> Void)? { get set }

}

class PlanDetailViewModel: PlanDetailViewModelType {
  // MARK: - Outputs
  
  var didFetchDataStart: (() -> Void)?
  var didFetchDataComplete: (() -> Void)?
  var networkError: (() -> Void)?
  var unexpectedError: (() -> Void)?
  var contentTableViewReload: (() -> Void)?
  var didUpdateWriterViewModel: ((PlanDetailWriterViewModel) -> Void)?
  var didUpdateSelectDayViewModel: ((PlanDetailSelectDayViewModel) -> Void)?
  var didUpdateSummaryCellViewModel: ((PlanDetailSummaryViewModel) -> Void)?
  var didUpdateinformationCellViewModel: (([PlanDetailInformationViewModel]) -> Void)?
  var didUpdateWriterBlockHeight: ((CGFloat) -> Void)?
  var showImageSlide: (([ImageForSlide]) -> Void)?

  // MARK: - Models
  
  var authorID :Int = 1
  var headerContentHeight: CGFloat = 0
  var headerData : DetailHeaderData?
  var locationList : [[PlanDetailMapData]] = [[]]
  var summaryList : [[PlanDetail.Summary]] = [[]]
  var infoList : [[PlanDetail.SpotData]] = [[]]
  var writerBlockHeight: CGFloat = 0
  var mapContainerHeight: CGFloat = 160
  var totalDay: Int = 1
  var initialScrollCompleted = false
  var isFullPage = false
  var isSummaryFold = true
  var currentDay: Int = 1
  
  // MARK: - DI
  private var repository: PlanDetailRepositoryInterface
  let postID: Int
  let isPreviewPage: Bool
  
  init(postId: Int,isPreviewPage: Bool,repository: PlanDetailRepositoryInterface){
    self.postID = postId
    self.isPreviewPage = isPreviewPage
    self.repository = repository
  }
}

extension PlanDetailViewModel {
  func viewDidLoad() {
    didFetchDataStart?()
    if !isPreviewPage {
      fetchDataFromRepository { [unowned self] in
        self.updateWriterViewModel()
        self.currentDayChanged(day: 1)
        print("END")
        self.didFetchDataComplete?()
      }
    }else{
      setPreviewDummy {
        self.updateWriterViewModel()
        self.currentDayChanged(day: 1)
        self.didFetchDataComplete?()
      }
    }
  }
  
  func currentDayChanged(day: Int){
    currentDay = day
    let dayViewModel = makeDaySelectViewModel(day: day)
    let summaryViewModel = makeSummaryViewModel(day: day)
    let infoViewModel = makeInformationViewModelList(day: day)
    didUpdateSelectDayViewModel?(dayViewModel)
    didUpdateSummaryCellViewModel?(summaryViewModel)
    didUpdateinformationCellViewModel?(infoViewModel)
    contentTableViewReload?()
  }
  
  func bottomContainerFoldChanged() {
    isFullPage = !isFullPage
    let dayViewModel = makeDaySelectViewModel(day: currentDay)
    didUpdateSelectDayViewModel?(dayViewModel)
    contentTableViewReload?()
  }
  
  func summaryFoldChanged(fold: Bool) {
    isSummaryFold = fold
    let summaryViewModel = makeSummaryViewModel(day: currentDay)
    didUpdateSummaryCellViewModel?(summaryViewModel)
    contentTableViewReload?()
  }
  
  func clickPhotos(urls: [String]){
    let images = urls.enumerated().map { index,url in
      ImageForSlide(title: String(index+1), url: URL(string: url)!)
    }
    showImageSlide?(images)
  }
  
  func bindRepository(){
    repository.networkError = { [weak self] err in
      if let error = err as? MoyaError{
        if error.response?.statusCode == 500{
          self?.networkError?()
        }else{
          self?.unexpectedError?()
        }
      }
    }
  }
}

// MARK: - Logics
extension PlanDetailViewModel {
  private func fetchDataFromRepository(completion: @escaping () -> Void){
    repository.fetchPlanDetailData(idx: postID) { [weak self]
      writer, authorID, title, totalDay, spots in
      guard let self = self else {return}
      self.locationList.removeAll()
      self.summaryList.removeAll()
      self.infoList.removeAll()
      
      self.headerData = DetailHeaderData(title: title, writer: writer)
      self.authorID = authorID
      self.totalDay = totalDay
      self.makeTopBlockHeight(content: title)
      
      for (_,daySpotDataList) in spots.enumerated(){
        var mapPointList : [PlanDetailMapData] = []
        var summaryList : [PlanDetail.Summary] = []
        var infoList : [PlanDetail.SpotData] = []
        for (_,eachDayData) in daySpotDataList.enumerated(){
          
          if let dayData = eachDayData{
            mapPointList.append(PlanDetailMapData.init(title: dayData.title,
                                                       latitude: dayData.latitude,
                                                       longtitude: dayData.longitude))
            
            let summary = PlanDetail.Summary.init(transportCase: self.makeTransportCase(mobilityName: dayData.nextSpotMobility),
                                                  locationName: dayData.title,
                                                  time: dayData.nextSpotRequiredTime)
            summaryList.append(summary)
            infoList.append(PlanDetail.SpotData(locationTitle: dayData.title,
                                                address: dayData.address,
                                                imagerUrls: dayData.photoUrls,
                                                textContent: dayData.spotDescription,
                                                nextLocationData: summary))
            
          }
        }
        self.locationList.append(mapPointList)
        self.summaryList.append(summaryList)
        self.infoList.append(infoList)
      }
      print("END333")
      completion()
    }
  }
  
  private func makeTransportCase(mobilityName : String) -> TransportCase{
    switch(mobilityName){
      case "도보" : return .walk
      case "지하철","버스","지하철타고가요" : return .bus
      default : return .car
    }
  }
  
  func makeTopBlockHeight(content : String){
    var writerTop : CGFloat
    let textViewForsizing = UITextView()
    textViewForsizing.font = .boldSystemFont(ofSize: 20)
    textViewForsizing.textContainer.lineFragmentPadding = .zero
    textViewForsizing.textContainerInset = .zero
    textViewForsizing.text = content
    textViewForsizing.sizeToFit()
    textViewForsizing.frame.width <= screenWidth - 48 ? (writerTop = 70) : (writerTop = 95)
    writerBlockHeight = writerTop
    didUpdateWriterBlockHeight?(writerBlockHeight)
  }
  
  private func updateWriterViewModel(){
    if let headerData = headerData{
      let viewModel = PlanDetailWriterViewModel.init(nickname: headerData.title,
                                                     title: headerData.writer,
                                                     isPreviewPage: isPreviewPage,
                                                     authID: authorID)
      didUpdateWriterViewModel?(viewModel)
    }
  }
  
  private func updateSelectDayModel(){
    
  }
  
}


extension PlanDetailViewModel {

  func makeDaySelectViewModel(day: Int) -> PlanDetailSelectDayViewModel {
    let viewModel = PlanDetailSelectDayViewModel(totalDay: infoList.count,
                                                 currentDay: day,
                                                 isFold: isFullPage)
    return viewModel
  }
  
  func makeSummaryViewModel(day: Int) -> PlanDetailSummaryViewModel {
    let summaryData = summaryList[day-1]
    var locationList: [PlanDetail.Summary] = []
    _ = summaryData.enumerated().map { index,data in
      locationList.append(PlanDetail.Summary.init(transportCase: data.transportCase,
                                                  locationName: data.locationName,
                                                  time: data.time))
    }
    let viewModel = PlanDetailSummaryViewModel(locationList: locationList, isFold: isSummaryFold)
    return viewModel
  }
  
  func makeInformationViewModelList(day: Int) -> [PlanDetailInformationViewModel] {
    let spotData = infoList[day-1]
    let viewModel = spotData.enumerated().map { index,data in
      PlanDetailInformationViewModel.init(title: data.locationTitle,
                                          address: data.address,
                                          imgUrls: data.imagerUrls,
                                          content: data.textContent,
                                          transport: data.nextLocationData?.transportCase,
                                          transportTime: data.nextLocationData?.time,
                                          nextTravel: index != spotData.count - 1 ? data.nextLocationData : nil)
    }
    return viewModel
  }
}
