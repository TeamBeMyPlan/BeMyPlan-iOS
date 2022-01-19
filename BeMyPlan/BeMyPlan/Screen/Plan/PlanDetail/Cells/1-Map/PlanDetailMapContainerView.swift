//
//  PlanDetailMapContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/19.
//

import UIKit

class PlanDetailMapContainerView: XibView,MTMapViewDelegate{

  // MARK: - var let Parts

  var centerPointList : [MTMapPointGeo] = []
  var mapPointList : [[PlanDetailMapData]] = [[]]
  var totalMapPointList : [PlanDetailMapData] = []
  var currentDay : Int = 0 { didSet {changedCurrentDay()}}
  
  
  // MARK: - UI Components Parts
  
  var mapView: MTMapView?
  @IBOutlet var mapContainerView: UIView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()
    setMapPointCenterPoint()
    setKakaoMap()
    setMapPoint()
    showMapCenter(pointList: totalMapPointList)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUI()
    setMapPointCenterPoint()
    setKakaoMap()
    setMapPoint()
    showMapCenter(pointList: totalMapPointList)
  }
  
  private func setUI(){
    mapContainerView.layer.cornerRadius = 5
    mapView = MTMapView(frame: self.mapContainerView.bounds)
    mapView?.layer.cornerRadius = 5
  }
  
  private func setMapPointCenterPoint(){
    for (_,pointList) in mapPointList.enumerated(){
      for (_,point) in pointList.enumerated(){
        totalMapPointList.append(point)
      }
    }
  }
  
  private func showMapCenter(pointList: [PlanDetailMapData]){
    if let mapView = mapView {
      mapView.fitArea(toShowMapPoints: makeMapPointGeoList(pointDataList: pointList))
    }
  }
  
  private func makeMapPointGeoList(pointDataList :[PlanDetailMapData]) -> [MTMapPoint]{
    var pointList :[MTMapPoint] = []
    for (_,item) in pointDataList.enumerated(){
      pointList.append(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  item.latitude,
                                                          longitude: item.longtitude)))
    }
    return pointList
  }
  
  
  private func makeMapItem(mapData : PlanDetailMapData,isEnabled : Bool) -> MTMapPOIItem{
    let mapItem = MTMapPOIItem()
    if isEnabled{
      mapItem.customImage = ImageLiterals.PlanDetail.mapUnselectIcon
      mapItem.markerType = .customImage
      mapItem.customSelectedImage = ImageLiterals.PlanDetail.mapSelectIcon
      mapItem.markerSelectedType = .customImage
      mapItem.itemName = mapData.title
    }else{
      mapItem.customImage = ImageLiterals.PlanDetail.mapUnselectIcon
      mapItem.markerType = .customImage
      mapItem.customSelectedImage = ImageLiterals.PlanDetail.mapUnselectIcon
      mapItem.markerSelectedType = .customImage
    }
    mapItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  mapData.latitude,
                                                          longitude: mapData.longtitude))
    
    return mapItem
  }
  
  private func setMapPoint(){
    if let mapView = mapView {
      for (_,mapDataList) in mapPointList.enumerated(){
        for (index,mapData) in mapDataList.enumerated(){
          mapView.add(makeMapItem(mapData: mapData, isEnabled: index == currentDay))
        }
      }
      self.mapContainerView.addSubview(mapView)
    }
  }
  
  
  private func changedCurrentDay(){
    if mapPointList.count >= currentDay + 1{
      showMapCenter(pointList: mapPointList[currentDay])
      setMapPoint()
    }
  }
  
  private func setKakaoMap(){
    if let mapView = mapView {
      mapView.delegate = self
      mapView.baseMapType = .standard
      
//      // 지도 중심점, 레벨
//      mapView.setMapCenter(MTMapPoint(geoCoord: defaultPosition), zoomLevel: 4, animated: true)
//
//
//      // 마커 추가
//      poiItem1?.showAnimationType = .dropFromHeaven
//      self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.55768857834471, longitude: 126.9244990846229))
//      poiItem1 = MTMapPOIItem()
//      poiItem1?.customImage = ImageLiterals.PlanDetail.mapUnselectIcon
//
//      poiItem1?.markerType = MTMapPOIItemMarkerType.customImage
//
//      poiItem1?.customSelectedImage = ImageLiterals.PlanDetail.mapSelectIcon
//
//      poiItem1?.markerSelectedType = .customImage
//      poiItem1?.mapPoint = mapPoint1
//      poiItem1?.itemName = "장소이름이 여기에 나올거에요~~~~~~"
//
//      poiItem2?.showAnimationType = .springFromGround
//      self.mapPoint2 = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.55768857834471, longitude: 126.9544990846229))
//
//      poiItem2 = MTMapPOIItem()
//      poiItem2?.customImage = ImageLiterals.PlanDetail.mapUnselectIcon
//
//      poiItem2?.markerType = MTMapPOIItemMarkerType.customImage
//
//      poiItem2?.customSelectedImage = ImageLiterals.PlanDetail.mapSelectIcon
//
//      poiItem2?.markerSelectedType = .customImage
//
//      poiItem2?.mapPoint = mapPoint2
//      poiItem2?.itemName = "장소이름이 여기에 나올거에요222~~~~~~"
//
//
//      mapView.add(poiItem1)
//      mapView.add(poiItem2)
//      self.mapContainerView.addSubview(mapView)
//      let pos2 = MTMapPointGeo(latitude: 37.55768857834471, longitude: 126.9544990846229)
//      mapView.setMapCenter(MTMapPoint(geoCoord: pos2), zoomLevel: 4, animated: true)
//
      
    }
  }
}


struct PlanDetailMapData{
  var title : String
  var latitude : Double
  var longtitude : Double
}
