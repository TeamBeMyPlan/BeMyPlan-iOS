//
//  PlanDetailMapContainerTVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class PlanDetailMapContainerTVC: UITableViewCell,UITableViewRegisterable, MTMapViewDelegate {
  
  // MARK: - var let Parts
  static var isFromNib: Bool = true
  public let defaultPosition = MTMapPointGeo(latitude: 37.576568, longitude: 127.029148)
  
  var mapPoint1: MTMapPoint?
  var mapPoint2: MTMapPoint?
  var poiItem1: MTMapPOIItem?
  var poiItem2: MTMapPOIItem?
  
  // MARK: - UI Components Parts
  
  var mapView: MTMapView?
  @IBOutlet var mapContainerView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUI()
    setKakaoMap()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  private func setUI(){
    mapContainerView.layer.cornerRadius = 5
    mapView = MTMapView(frame: self.mapContainerView.bounds)
  }
  
  private func setKakaoMap(){
    if let mapView = mapView {
      mapView.delegate = self
      mapView.baseMapType = .standard
      
      // 지도 중심점, 레벨
      mapView.setMapCenter(MTMapPoint(geoCoord: defaultPosition), zoomLevel: 4, animated: true)
      
      
      // 마커 추가
      poiItem1?.showAnimationType = .dropFromHeaven
      self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.55768857834471, longitude: 126.9244990846229))
      poiItem1 = MTMapPOIItem()
      poiItem1?.customImage = ImageLiterals.PlanDetail.mapUnselectIcon
      
      poiItem1?.markerType = MTMapPOIItemMarkerType.customImage
      
      poiItem1?.customSelectedImage = ImageLiterals.PlanDetail.mapSelectIcon
      
      poiItem1?.markerSelectedType = .customImage
      poiItem1?.mapPoint = mapPoint1
      poiItem1?.itemName = "장소이름이 여기에 나올거에요~~~~~~"
      
      poiItem2?.showAnimationType = .springFromGround
      self.mapPoint2 = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.55768857834471, longitude: 126.9544990846229))
      
      poiItem2 = MTMapPOIItem()
      poiItem2?.customImage = ImageLiterals.PlanDetail.mapUnselectIcon
      
      poiItem2?.markerType = MTMapPOIItemMarkerType.customImage
      
      poiItem2?.customSelectedImage = ImageLiterals.PlanDetail.mapSelectIcon
      
      poiItem2?.markerSelectedType = .customImage
      
      poiItem2?.mapPoint = mapPoint2
      poiItem2?.itemName = "장소이름이 여기에 나올거에요222~~~~~~"
      
      
      
      mapView.add(poiItem1)
      mapView.add(poiItem2)
      self.mapContainerView.addSubview(mapView)
      let pos2 = MTMapPointGeo(latitude: 37.55768857834471, longitude: 126.9544990846229)
      mapView.setMapCenter(MTMapPoint(geoCoord: pos2), zoomLevel: 4, animated: true)
      
      
    }
  }
}
