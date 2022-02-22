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
  
  // Outputs
  var contentFoldState: ((Bool,CGFloat) -> Void)? { get set }
  var currentDay: ((Int) -> Void)? { get set }
  var didFetchDataStart: (() -> Void)? { get set }
  var didFetchDataComplete: (() -> Void)? { get set }
  var networkError: (() -> Void)? { get set }
  var unexpectedError: (() -> Void)? { get set }
  
}

class PlanDetailViewModel: PlanDetailViewModelType {
  // MARK: - Outputs
  
  var contentFoldState: ((Bool,CGFloat) -> Void)?
  var currentDay: ((Int) -> Void)?
  var didFetchDataStart: (() -> Void)?
  var didFetchDataComplete: (() -> Void)?
  var networkError: (() -> Void)?
  var unexpectedError: (() -> Void)?

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
  var isSummaryFold = true
  
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
    fetchData { [unowned self] in
      self.didFetchDataComplete?()
    }
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
  private func fetchData(completion: @escaping () -> Void){
    repository.fetchPlanDetailData(idx: postID) { [weak self]
      writer, authorID, title, totalDay, spots in
      guard let self = self else {return}
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
  
  private func makeTopBlockHeight(content : String){
    var writerTop : CGFloat
    let textViewForsizing = UITextView()
    textViewForsizing.font = .boldSystemFont(ofSize: 20)
    textViewForsizing.textContainer.lineFragmentPadding = .zero
    textViewForsizing.textContainerInset = .zero
    textViewForsizing.text = content
    textViewForsizing.sizeToFit()
    textViewForsizing.frame.width <= screenWidth - 48 ? (writerTop = 70) : (writerTop = 95)
    writerBlockHeight = writerTop
  }
  
}
