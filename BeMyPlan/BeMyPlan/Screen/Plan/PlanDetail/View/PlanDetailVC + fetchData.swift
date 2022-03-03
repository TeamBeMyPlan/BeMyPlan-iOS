//
//  PlanDetailVC + fetchData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation
import SnapKit

//extension PlanDetailVC{
//  func fetchPlanDetailData(){
//    BaseService.default.getPlanDetailData(idx: postIdx) { result in
//      result.success { [weak self] data in
//        
//        self?.locationList.removeAll()
//        self?.summaryList.removeAll()
//        self?.infoList.removeAll()
//        if let detailData = data{
//          // 작성자 정보 가져오기
//          
//          self?.authID = data?.authorID ?? 0
//          self?.headerData = DetailHeaderData(title: detailData.title,
//                                              writer : detailData.author)
//          self?.headerTitleLabel.text = detailData.title
//          self?.headerTitleLabel.isHidden = true
//          self?.makeTopBlockHeight(content: detailData.title)
//          // 총 일차 가져오기
//          self?.totalDay = detailData.totalDays
//          // 각각 리스트 더해주기
//          for (_,daySpotDataList) in detailData.spots.enumerated(){
//            var mapPointList : [PlanDetailMapData] = []
//            var summaryList : [PlanDetail.Summary] = []
//            var infoList : [PlanDetail.SpotData] = []            
//            for (_,eachDayData) in daySpotDataList.enumerated(){
//              
//              if let dayData = eachDayData{
//                mapPointList.append(PlanDetailMapData.init(title: dayData.title,
//                                                           latitude: dayData.latitude,
//                                                           longtitude: dayData.longitude))
//                
//                let summary = PlanDetail.Summary.init(transportCase: self?.makeTransportCase(mobilityName: dayData.nextSpotMobility),
//                                                      locationName: dayData.title,
//                                                      time: dayData.nextSpotRequiredTime)
//                summaryList.append(summary)
//                infoList.append(PlanDetail.SpotData(locationTitle: dayData.title,
//                                                    address: dayData.address,
//                                                    imagerUrls: dayData.photoUrls,
//                                                    textContent: dayData.spotDescription,
//                                                    nextLocationData: summary))
//                
//              }
//            }
//            self?.locationList.append(mapPointList)
//            self?.summaryList.append(summaryList)
//            self?.infoList.append(infoList)
//          }
//          self?.mainContainerTV.reloadData()
//          self?.setWriterView()
//          self?.setMapContainerView()
//        }
//        self?.closeIndicator {
//          UIView.animate(withDuration: 1){
//            self?.mainContainerTV.alpha = 1
//          }
//        }
//        
//      }.catch { err in
//        self.closeIndicator {
//          print("🍎DETAIL ERRR")
//          dump(err)
//          self.postObserverAction(.showNetworkError)
//        }
//      }
//    }
//  }
//  
//  private func makeTransportCase(mobilityName : String) -> TransportCase{
//    switch(mobilityName){
//      case "도보" : return .walk
//      case "지하철","버스","지하철타고가요" : return .bus
//      default : return .car
//    }
//  }
//  
//  func makeTopBlockHeight(content : String){
//    var writerTop : CGFloat
//    let textViewForsizing = UITextView()
//    textViewForsizing.font = .boldSystemFont(ofSize: 20)
//    textViewForsizing.textContainer.lineFragmentPadding = .zero
//    textViewForsizing.textContainerInset = .zero
//    textViewForsizing.text = content
//    textViewForsizing.sizeToFit()
//    textViewForsizing.frame.width <= screenWidth - 48 ? (writerTop = 70) : (writerTop = 95)
//    writerBlockHeightConstraint.constant = writerTop
//    let mapContainerHeight : CGFloat = 160
//    mainTVTopConstraint.constant = writerTop + mapContainerHeight
//    headerContentHeight = writerTop + mapContainerHeight
//    self.view.layoutIfNeeded()
//  }
//}
//
////도보 택시,버스,지하철
