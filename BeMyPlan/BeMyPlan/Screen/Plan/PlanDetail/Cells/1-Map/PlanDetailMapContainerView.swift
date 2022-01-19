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
  var mapPointList : [[PlanDetailMapData]] = [[]]{
    didSet{
      setMapPointCenterPoint()
      setMapPoint()
      showMapCenter(pointList: totalMapPointList)
    }
  }
  var totalMapPointList : [PlanDetailMapData] = []
  var currentDay : Int = 1 { didSet {changedCurrentDay()}}
  
  
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
      print("FIT Area Points",pointList)
      mapView.fitArea(toShowMapPoints: makeMapPointGeoList(pointDataList: pointList))
    }
  }
  
  private func makeMapPointGeoList(pointDataList :[PlanDetailMapData]) -> [MTMapPoint]{
    var pointList :[MTMapPoint] = []
    for (_,item) in pointDataList.enumerated(){
      pointList.append(MTMapPoint(geoCoord: MTMapPointGeo(latitude:  item.latitude,
                                                          longitude: item.longtitude)))
      print("Result Point List",item.latitude,item.longtitude)
    }

    return pointList
  }
  
  
  private func makeMapItem(mapData : PlanDetailMapData,isEnabled : Bool) -> MTMapPOIItem{
    let mapItem = MTMapPOIItem()
    if isEnabled{
      let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
      view.backgroundColor = .blue
      
      mapItem.customImage = ImageLiterals.PlanDetail.mapSelectIcon
      mapItem.markerType = .customImage
      mapItem.customSelectedImage = ImageLiterals.PlanDetail.mapSelectIconClicked
      mapItem.markerSelectedType = .customImage
      mapItem.itemName = mapData.title
      mapItem.customCalloutBalloonView = view
    }else{
      mapItem.customImage = ImageLiterals.PlanDetail.mapUnselectIcon
      mapItem.markerType = .customImage
      mapItem.customSelectedImage = ImageLiterals.PlanDetail.mapUnselectIcon
      mapItem.markerSelectedType = .customImage
    }
    mapItem.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  mapData.latitude,
                                                          longitude: mapData.longtitude))
    
    print("만들어지는 아이템",mapData.title,mapData.latitude,mapData.longtitude,isEnabled)
    return mapItem
  }
  
  private func setMapPoint(){
    mapView?.removeAllPOIItems()
    if let mapView = mapView {
      for (index,mapDataList) in mapPointList.enumerated(){
        for (_,mapData) in mapDataList.enumerated(){
          mapView.add(makeMapItem(mapData: mapData, isEnabled: index == currentDay - 1))
        }
      }
      self.mapContainerView.addSubview(mapView)
    }
  }
  
  private func changedCurrentDay(){
    
    print("MAPPOINTLIST Count",mapPointList.count)
    print("currentDay",currentDay)
    
    if mapPointList.count >= currentDay && currentDay > 0 {
      showMapCenter(pointList: mapPointList[currentDay - 1])
    }
    print("setMAPoint")
    setMapPoint()
  }
  
  private func setKakaoMap(){
    if let mapView = mapView {
      mapView.delegate = self
      mapView.baseMapType = .standard
    }
  }
  
  func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
    print("터치?",poiItem.itemName)
  }
}


struct PlanDetailMapData{
  var title : String
  var latitude : Double
  var longtitude : Double
}
