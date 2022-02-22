//
//  PlanDetailMapContainerView.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/19.
//

import UIKit



class PlanDetailMapContainerView: XibView,MTMapViewDelegate{
  
  // MARK: - View Model

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
  var currentDay : Int = 1 { didSet {changedCurrentDay() }}
  var currentIndex : Int = 0 { didSet{ showEachPlaceCenter() }}
  
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
  
  private func showEachPlaceCenter(){
    if currentIndex > 0 && currentDay > 0 && mapPointList.count > 0{
      let data = mapPointList[currentDay - 1][currentIndex - 1]
      showMapCenter(pointList: [data])
    }else{
      if mapPointList.count >= currentDay && currentDay > 0 {
        showMapCenter(pointList: mapPointList[currentDay - 1])
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
//      let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//      view.backgroundColor = .blue
      
      mapItem.customImage = ImageLiterals.PlanDetail.mapSelectIcon
      mapItem.markerType = .customImage
      mapItem.customSelectedImage = ImageLiterals.PlanDetail.mapSelectIconClicked
      mapItem.markerSelectedType = .customImage
      mapItem.itemName = mapData.title
      mapItem.customCalloutBalloonView = makeBallonView(title: mapData.title)
      
      mapItem.customImageAnchorPointOffset = MTMapImageOffset.init(offsetX: 42, offsetY: 0)
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
  
  private func makeBallonView(title : String) -> MapBallonView {
    let ballonView = MapBallonView.init(frame: CGRect(x: 20, y:10, width: makeBallonWidth(name: title), height: 26 ))
    ballonView.setLabel(title: title)
    return ballonView
  }
  
  private func makeBallonWidth(name : String) -> CGFloat{
    let sizingLabel = UILabel()
    sizingLabel.font = .systemFont(ofSize: 12)
    sizingLabel.text = name
    sizingLabel.sizeToFit()
    if sizingLabel.frame.width <= 120{
      return sizingLabel.frame.width + 30
    }else{
      return 120 + 30
    }
  }
  
  private func setMapPoint(){
    mapView?.removeAllPOIItems()
    if let mapView = mapView {
      for (index,mapDataList) in mapPointList.enumerated(){
        for (_,mapData) in mapDataList.enumerated(){
          let state : Bool
          if currentDay == 0{
            state = (index == 0)
          }else{
            state = (index == currentDay - 1)
          }
          mapView.add(makeMapItem(mapData: mapData, isEnabled: state))
        }
      }
      self.mapContainerView.addSubview(mapView)
    }
  }
  
  private func changedCurrentDay(){
    if mapPointList.count >= currentDay && currentDay > 0 {
      showMapCenter(pointList: mapPointList[currentDay - 1])
    }
    setMapPoint()
  }
  
  private func setKakaoMap(){
    if let mapView = mapView {
      mapView.delegate = self
      mapView.baseMapType = .standard
    }
  }
  
  func mapView(_ mapView: MTMapView!, touchedCalloutBalloonOf poiItem: MTMapPOIItem!) {
    if let placeName = poiItem.itemName{ openKaKaoMap(place: placeName) }
  }
  
  private func openKaKaoMap(place : String){
    let searchURL = makeMapsURL(place: place, platform: .kakao)
    if let appUrl = searchURL{
      if(UIApplication.shared.canOpenURL(appUrl)){
        UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
      }else{
        let searchURL = makeMapsURL(place: place, platform: .kakao)
        if let appUrl = searchURL{
          if(UIApplication.shared.canOpenURL(appUrl)){
            UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
          }else{
            postObserverAction(.showNotInstallKakaomap)
          }
        }
      }
    }
  }
  
  private func makeMapsURL(place: String,platform : MapPlatform) -> URL?{
    let urlString : String
    platform == .naver ? (urlString = "nmap://search?query=\(place)&appname=com.release.BeMyPlan") : (urlString = "kakaomap://search?q=\(place)")
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let searchURL = URL(string: encodedString)
    return searchURL
  }
}

struct PlanDetailMapData{
  var title : String
  var latitude : Double
  var longtitude : Double
}
enum MapPlatform{
  case kakao
  case naver
}
