//
//  ViewController.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/04.
//

import UIKit

public let defaultPosition = MTMapPointGeo(latitude: 37.576568, longitude: 127.029148)
class ViewController: UIViewController, MTMapViewDelegate {

  @IBOutlet var sampleview: UIView!
    var mapView: MTMapView?
    
    var mapPoint1: MTMapPoint?
    var poiItem1: MTMapPOIItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      UIFont.familyNames.forEach({ familyName in
          let fontNames = UIFont.fontNames(forFamilyName: familyName)
          print(familyName, fontNames)
      })
        
        // 지도 불러오기
        mapView = MTMapView(frame: self.sampleview.bounds)
        
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            
            // 지도 중심점, 레벨
            mapView.setMapCenter(MTMapPoint(geoCoord: defaultPosition), zoomLevel: 4, animated: true)
            
            // 현재 위치 트래킹
            mapView.showCurrentLocationMarker = true
            mapView.currentLocationTrackingMode = .onWithoutHeading
            
            // 마커 추가
          poiItem1?.showAnimationType = .dropFromHeaven
            self.mapPoint1 = MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.585568, longitude: 127.019148))
            poiItem1 = MTMapPOIItem()
          poiItem1?.customImage = UIImage(named: "btn_process_active")!
          
          poiItem1?.markerType = MTMapPOIItemMarkerType.customImage
            poiItem1?.mapPoint = mapPoint1
            poiItem1?.itemName = "아무데나 찍어봄"
          
            mapView.add(poiItem1)
            
//            mapView.addPOIItems([poiItem1,poiItem2]
//            mapView.fitAreaToShowAllPOIItems()
            
            self.sampleview.addSubview(mapView)
        }
        
    }
    
  @IBAction func trackButtonClicked(_ sender: Any) {
    let pos1 = MTMapPointGeo(latitude: 37.585568, longitude: 127.019148)
    mapView!.setMapCenter(MTMapPoint(geoCoord: pos1), zoomLevel: 4, animated: true)
  }
  @IBAction func trackButton2Clicked(_ sender: Any) {
    let pos2 = MTMapPointGeo(latitude: 37.906568, longitude: 127.029148)
    mapView!.setMapCenter(MTMapPoint(geoCoord: pos2), zoomLevel: 4, animated: true)
  }
  
  @IBAction func drawLIneButonClicked(_ sender: Any) {
    let pointList = [
      MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.585568, longitude: 127.019148)),
      MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.595568, longitude: 127.019348)),
      MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.605568, longitude: 127.009148)),
      MTMapPoint(geoCoord: MTMapPointGeo(latitude:  37.615568, longitude: 127.0048))
      ]
  
    let polyLine = MTMapPolyline.polyLine()
    polyLine?.polylineColor = .red
    polyLine?.addPoints(pointList)
    mapView?.addPolyline(polyLine)
    mapView?.fitAreaToShowAllPolylines()

  }
  // Custom: 현 위치 트래킹 함수
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocation = location?.mapPointGeo()
        if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{
            print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
        }
    }
    
    func mapView(_ mapView: MTMapView?, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle)) degrees")
    }
    
}
