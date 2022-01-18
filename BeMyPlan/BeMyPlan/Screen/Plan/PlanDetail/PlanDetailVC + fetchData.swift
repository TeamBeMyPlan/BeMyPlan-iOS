//
//  PlanDetailVC + fetchData.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/18.
//

import Foundation

extension PlanDetailVC{
  func fetchPlanDetailData(){
    BaseService.default.getPlanDetailData(idx: postIdx) { result in
      result.success { [weak self] data in
        self?.locationList.removeAll()
        self?.summaryList.removeAll()
        self?.infoList.removeAll()
        if let detailData = data{
          // 작성자 정보 가져오기
          self?.headerData = DetailHeaderData(title: detailData.title,
                                              writer : detailData.author)
          self?.headerTitleLabel.text = detailData.title
          // 총 일차 가져오기
          self?.totalDay = detailData.totalDays
          // 각각 리스트 더해주기
          for (_,daySpotDataList) in detailData.spots.enumerated(){
            var mapPointList : [PlanDetailMapData] = []
            var summaryList : [PlanDetail.Summary] = []
            var infoList : [PlanDetail.SpotData] = []
            print("DAYSPOTLIST",daySpotDataList.count)

            for (_,eachDayData) in daySpotDataList.enumerated(){

              if let dayData = eachDayData{
                mapPointList.append(PlanDetailMapData.init(title: dayData.title,
                                                           latitude: dayData.latitude,
                                                           longtitude: dayData.longitude))
                
                let summary = PlanDetail.Summary.init(transportCase: self?.makeTransportCase(mobilityName: dayData.title),
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
            self?.locationList.append(mapPointList)
            self?.summaryList.append(summaryList)
            self?.infoList.append(infoList)
          }
          print(self?.locationList.count)
          dump(self?.locationList)
          print(self?.summaryList.count)
          dump(dump(self?.locationList))
          print(self?.infoList.count)
          dump(self?.infoList)

          self?.mainContainerTV.reloadData()
        }
      }
    }
  }
  
  private func makeTransportCase(mobilityName : String) -> TransportCase{
    switch(mobilityName){
      case "도보" : return .walk
      case "지하철","버스","지하철타고가요" : return .bus
      default : return .car
    }
  }
}

//도보 택시,버스,지하철
