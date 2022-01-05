/**
 * @brief Daum Map View Class
 * @file MTMapView.h
 * @author Byung-Wan Lim (bwlim@daumcorp.com)
 * @date 2011/11/04
 * @copyright
 * Copyright 2012 Daum Communications Corp. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <DaumMap/MTMapGeometry.h>
#import <DaumMap/MTMapPOIItem.h>
#import <DaumMap/MTMapPolyline.h>
#import <DaumMap/MTMapCircle.h>
#import <DaumMap/MTMapLocationMarkerItem.h>


@class MTMapViewInternal;
@class MTMapCameraUpdate;

@protocol MTMapViewDelegate;

/**
 * 지도 종류 enumeration
 * @see MTMapView.baseMapType property
 */
typedef NS_ENUM(NSInteger, MTMapType) {
	MTMapTypeStandard, /**< 기본 지도 */
	MTMapTypeSatellite, /**< 위성 지도 */
	MTMapTypeHybrid /**< 하이브리드 지도 */
};

/**
 * 현위치 트랙킹 타입 enumeration
 * @see MTMapView.currentLocationTrackingMode property
 */
typedef NS_ENUM(NSInteger, MTMapCurrentLocationTrackingMode) {
	MTMapCurrentLocationTrackingOff, /**< 현위치 트랙킹 모드 및 나침반 모드 Off */
	MTMapCurrentLocationTrackingOnWithoutHeading, /**< 현위치 트랙킹 모드 On, 단말의 위치에 따라 지도 중심이 이동한다. 나침반 모드는 꺼진 상태 */
	MTMapCurrentLocationTrackingOnWithHeading, /**< 현위치 트랙킹 모드 On + 나침반 모드 On, 단말의 위치에 따라 지도 중심이 이동하며 단말의 방향에 따라 지도가 회전한다.(나침반 모드 On) */
    MTMapCurrentLocationTrackingOnWithoutHeadingWithoutMapMoving,
    MTMapCurrentLocationTrackingOnWithHeadingWithoutMapMoving,
};

/**
 * Zoom Level 데이터 타입 (integer)
 */
typedef int MTMapZoomLevel;

/**
 * @brief Daum 지도 화면을 보여주는 View Class.
 * MTMapView를 생성하여 Daum 지도 화면을 보여주는 View를 사용할 수 있다.
 * 지도 종류 지정, 지도 화면 이동/확대/축소, 
 * 현위치 트래킹 및 나침반 모드, POI Item(MTMapPOIItem) 관리, Polyline(MTMapPolyline) 관리 등의 기능이 제공된다.
 * MTMapViewDelegate protocol을 구현하는 delegate객체를 지정하여 
 * 지도에서 발생하는 다양한 이벤트들을 통보받을 수 있다.
 * 동시에 두개 이상의 MTMapView 객체를 생성하여 사용하는 것은 허용되지 않는다.
 * @see MTMapPoint, MTMapPOIItem, MTMapPolyline, MTMapViewDelegate
 */
@interface MTMapView : UIView {
@private
	MTMapViewInternal* _internalImpl;
}

/**
 * Daum Map Open API Key 발급 페이지에서 발급 받은 API Key를 설정한다.
 * Open API Key 는 App. Bundle Id 당 하나씩 발급 된다.
 * Open API Key는 지도화면이 화면에 보여지기 전에 반드시 설정되어야 한다.
 * 설정된 Open API Key가 정상적으로 등록되지 않은 Key 이거나 
 * 트래픽 제한에 걸린 경우에는 다음 지도 화면 사용이 제한될 수 있다.
 */
@property (nonatomic, retain) NSString *daumMapApiKey __deprecated_msg("Info.plist의 KAKAO_APP_KEY의 값을 읽어 오도록 수정되었습니다. daumMapApiKey는 더이상 작동 하지 않습니다.");

/**
 * 지도 객체에서 발생하는 이벤트를 처리할 delegate 객체를 설정한다.
 * delegate 객체는 Open API Key 인증 결과 이벤트, 지도 이동/확대/축소,
 * 지도 화면 터치(Single Tap / Double Tap / Long Press) 이벤트,
 * 현위치 트래킹 이벤트, POI(Point Of Interest) 관련 이벤트를 통보받을 수 있다.
 */
@property (nonatomic, assign) id<MTMapViewDelegate> delegate;

/**
 * 지도 종류(기본 지도, 위성 지도, 하이브리드 지도)를 지정하거나 현재 보여주고 있는 지도 종류를 확인할 수 있다.
 */
@property (nonatomic) MTMapType baseMapType;

/**
 * 고해상도 지도 타일 사용 여부를 설정한다.
 * Retina Display인 경우 기본값은 YES, 아닌경우 기본값은 NO
 */
@property (nonatomic) BOOL useHDMapTile;

/**
 * 지도 타일 이미지 Persistent Cache 기능 활성화 여부를 조회한다.
 * @return Persistent Cache 기능 활성화 여부
 */
+ (BOOL)isMapTilePersistentCacheEnabled;

/**
 * 지도 타일 이미지 Persistent Cache 기능은
 * 네트워크를 통해 다운로드한 지도 이미지 데이터를
 * 단말의 영구(persistent) 캐쉬 영역에 저장하는 기능이다.
 * 같은 영역의 지도를 다시 로드할때 캐쉬에 저장된 지도 타일들은
 * 네트워크를 통해 다운로드 받지 않고 단말의 캐쉬에서 바로 로드하여
 * 네트워크 사용량을 줄이고 지도 로딩 시간을 단축할 수 있다.
 * 사용되지 않는 지도 타일 이미지 캐쉬 데이터는 MapView 동작 중에 자동으로
 * 삭제되어 캐쉬 용량의 크기가 너무 커지지 않도록 조절된다.
 * Application의 Cache 영역 사용량이 부담이 되면 Cache 기능을 비활성화 하는 것이 좋다.
 * MTMapView가 동작하는 중에는 Cache 기능 활성화 설정 변경이 적용되지 않으며
 * MTMapView를 사용하기 전에 Cache 활성화 여부를 설정해야 한다.
 * @param enableCache Persistent Cache 기능 활성화 여부
 */
+ (void)setMapTilePersistentCacheEnabled:(BOOL)enableCache;

/**
 * Application의 Document Directory의 임시 디렉토리에
 * 저장된 지도 타일 캐쉬 데이터를 모두 삭제한다.
 * MTMapView가 동작 중인 상태에서도 사용가능하다.
 */
+ (void)clearMapTilePersistentCache;

/**
 * 현위치를 표시하는 아이콘(마커)를 화면에 표시할지 여부를 설정한다.
 * currentLocationTrackingMode property를 이용하여 현위치 트래킹 기능을 On 시키면 자동으로 현위치 마커가 보여지게 된다.
 * 현위치 트래킹 기능을 Off한 후에 현위치 아이콘을 지도 화면에서 제거할 때 사용할 수 있다.
 */
@property (nonatomic) BOOL showCurrentLocationMarker;

/**
 * 화면상에 보이는 현위치 마커의 UI를 업데이트 한다.
 * @param locationMarkerItem 현위치 마커 정보. nil일 경우, Default 현위치 마커로 노출된다.
 */
- (void)updateCurrentLocationMarker:(MTMapLocationMarkerItem *)locationMarkerItem;

/**
 * 현위치 트래킹 모드 및 나침반 모드를 설정한다.
 * - 현위치 트래킹 모드 : 지도화면 중심을 단말의 현재 위치로 이동시켜줌
 * - 나침반 모드 : 단말의 방향에 따라 지도화면이 회전됨
 * 현위치 트래킹 모드만 On시키거나 현위치 트래킹 모드, 나침반 모드 둘다 On 시킬 수 있다.
 * 현위치 트래킹/나침반 모드를 활성화 시키면 현위치 정보가 설정된 MTMapViewDelegate 객체에 전달된다.
 * @see MTMapCurrentLocationTrackingMode
 * @see MTMapViewDelegate
 */
@property (nonatomic) MTMapCurrentLocationTrackingMode currentLocationTrackingMode;

/**
 * 현재 지도 화면의 중심점을 확인할 수 있다.
 */
@property (nonatomic, readonly) MTMapPoint* mapCenterPoint;

/**
 * 현재 지도 화면의 좌하단, 우상단 영역을 확인할 수 있다.
 */
@property (nonatomic, readonly) MTMapBoundsRect* mapBounds;


/**
 * 현재 지도 화면의 확대/축소 레벨을 확인할 수 있다.
 */
@property (nonatomic, readonly) MTMapZoomLevel zoomLevel;

/**
 * 현재 지도화면의 회전 각도(360 degree)를 확인할 수 있다.
 */
@property (nonatomic, readonly) MTMapRotationAngle mapRotationAngle;

//@property (nonatomic) BOOL zoomEnabled;
//@property (nonatomic) BOOL panEnabled;

/**
 * 지도 화면의 중심점을 설정한다.
 * @param mapPoint 지도화면 중심점을 나타내는 MTMapPoint 객체
 * @param animated 지도화면 중심점 이동시 애니매이션 효과를 적용할지 여부
 */
- (void)setMapCenterPoint:(MTMapPoint*)mapPoint animated:(BOOL)animated;

/**
 * 지도 화면의 중심점과 확대/축소 레벨을 설정한다.
 * @param mapPoint 지도화면 중심점을 나타내는 MTMapPoint 객체
 * @param zoomLevel 지도화면 확대 축소 레벨 값 (-2~12, 값이 클수록 더 넓은 영역이 화면이 보임)
 * @param animated 지도화면 중심점 이동 및 확대/축소 레벨 변경시 애니매이션 효과를 적용할지 여부
 */
- (void)setMapCenterPoint:(MTMapPoint*)mapPoint zoomLevel:(MTMapZoomLevel)zoomLevel animated:(BOOL)animated;

/**
 * 지도 화면의 확대/축소 레벨을 설정한다.
 * @param zoomLevel 지도화면 확대 축소 레벨 값 (-2~12, 값이 클수록 더 넓은 영역이 화면이 보임)
 * @param animated 지도화면의 확대/축소 레벨 변경시 애니매이션 효과를 적용할지 여부
 */
- (void)setZoomLevel:(MTMapZoomLevel)zoomLevel animated:(BOOL)animated;

/**
 * 지도 화면을 한단계 확대한다. (더 좁은 영역이 크게 보임)
 * 확대/축소 레벨 값이 1 감소됨
 * @param animated 지도화면의 확대 시 애니매이션 효과를 적용할지 여부
 */
- (void)zoomInAnimated:(BOOL)animated;

/**
 * 지도 화면을 한단계 축소한다. (더 넓은 영역이 화면에 나타남)
 * 확대/축소 레벨 값이 1 증가됨
 * @param animated 지도화면의 축소 시 애니매이션 효과를 적용할지 여부
 */
- (void)zoomOutAnimated:(BOOL)animated;

/**
 * 지도 화면의 회전 각도를 설정한다.
 * @param angle 회전 각도 (0~360도)
 * @param animated 회전 각도 변경시 애니매이션 효과를 적용할지 여부
 */
- (void)setMapRotationAngle:(MTMapRotationAngle)angle animated:(BOOL)animated;

/**
 * 지정한 지도 좌표들이 모두 화면에 나타나도록 지도화면 중심과 확대/축소 레벨을 자동조절 한다.
 * @param mapPoints 화면에 모두 보여주고자 하는 지도 좌표 리스트 (Array of MTMapPoint) 
 */
- (void)fitMapViewAreaToShowMapPoints:(NSArray*)mapPoints;

/**
 * 지도 화면 이동 혹은 확대/축소 시킨다.
 * @param cameraUpdate 지도 화면 이동을 위한 중심점, 확대/축소 레벨 등을 지정한 MTMapCameraUpdate 객체
 */
- (void)animateWithCameraUpdate:(MTMapCameraUpdate *)cameraUpdate;

/**
 * 지도 화면에 나타나는 지도 타일들을 지도 타일 서버에서 다시 받아와서 갱신한다.
 */
- (void)refreshMapTiles;

/**
 * MTMapView를 포함하고 있는 UIViewController 객체의 didReceiveMemoryWarning 메소드 구현에서 호출해 주어야 한다.
 * iOS에서 Memory Warning 발생시 메모리에 저장하고 있는 
 * 지도 타일 이미지 캐쉬 데이터 들을 삭제하여 메모리를 확보할 수 있다.
 */
- (void)didReceiveMemoryWarning;

//- (CGPoint)viewPointFromMapPoint:(MTMapPoint*)mapPoint;
//- (MTMapPoint*)mapPointFromViewPoint:(CGPoint)viewPoint;

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// MTMapPOIItem

/**
 * 지도화면에 보여주고 있는 POI(Point Of Interest) 아이템 리스트를 조회할 수 있다.
 */
@property (nonatomic, readonly) NSArray* poiItems;

/**
 * 지도화면에 POI(Point Of Interest) Item 아이콘(마커)를 추가한다.
 * @param poiItem 추가할 POI Item 객체
 */
- (void)addPOIItem:(MTMapPOIItem*)poiItem;

/**
 * 지도화면에 POI(Point Of Interest) Item 아이콘(마커) 리스트를 추가한다.
 * @param poiItems 추가할 POI Item 객체 리스트 (array of MTMapPOIItem(s))
 */
- (void)addPOIItems:(NSArray *)poiItems;

/**
 * 특정 POI(Point Of Interest) Item 을 선택한다.
 * 선택된 POI Item은 Callout Balloon(말풍선)이 아이콘(마커)위에 나타난다.
 * @param poiItem 선택할 POI Item 객체
 * @param animated POI Item 선택시 말풍선이 나타날 때 애니매이션 효과가 적용될 지 여부
 */
- (void)selectPOIItem:(MTMapPOIItem*)poiItem animated:(BOOL)animated;

/**
 * 특정 POI(Point Of Interest) Item 을 선택 해제한다.
 * 선택 해제된 POI Item은 Callout Balloon(말풍선)이 POI 아이콘(마커)위에서 사라진다.
 * @param poiItem 선택 해제할 POI Item 객체
 */
- (void)deselectPOIItem:(MTMapPOIItem*)poiItem;

/**
 * 지도화면에 추가된 POI(Point Of Interest) Item 들 중에서 tag값이 일치하는 POI Item을 찾는다.
 * @param tag 찾고자 하는 POI Item의 tag 값
 * @return tag가 일치하는 POI Item 객체, 일치하는 POI Item이 없는 경우 nil이 리턴된다.
 */
- (MTMapPOIItem*)findPOIItemByTag:(NSInteger)tag;

/**
 * 지도화면에 추가된 POI(Point Of Interest) Item 들 중에서 이름이 일치하는 POI Item 객체(리스트)를 찾는다.
 * @param name 찾고자 하는 POI Item의 이름 문자열
 * @return 이름 문자열이 일치하는 POI Item 객체(리스트), 일치하는 POI Item이 없는 경우 nil이 리턴된다.
 */
- (NSArray*)findPOIItemByName:(NSString*)name;

/**
 * 특정 POI(Point Of Interest) Item을 지도화면에서 제거한다.
 * @param poiItem 제거하고자 하는 POI Item 객체
 */
- (void)removePOIItem:(MTMapPOIItem*)poiItem;

/**
 * POI(Point Of Interest) Item 리스트를 지도화면에서 제거한다.
 * @param poiItems 제거하고자 하는 POI Item 객체 리스트
 */
- (void)removePOIItems:(NSArray *)poiItems; // array of MTMapPOIItem(s)

/**
 * 지도 화면에 추가된 모든 POI(Point Of Interest) Item들을 제거한다.
 */
- (void)removeAllPOIItems;

/**
 * 지도 화면에 추가된 모든 POI(Point Of Interest) Item들이 
 * 화면에 나타나도록 지도 화면 중심과 확대/축소 레벨을 자동으로 조정한다.
 */
- (void)fitMapViewAreaToShowAllPOIItems;

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// MTMapPolyline

/**
 * 지도화면에 보여주고 있는 Polyline 리스트를 조회할 수 있다.
 */
@property (nonatomic, readonly) NSArray* polylines;

/**
 * 지도화면에 Polyline을 추가한다.
 * @param polyline 추가할 Polyline 객체
 */
- (void)addPolyline:(MTMapPolyline*)polyline;

/**
 * 지도화면에 추가된 Polyline들 중에서 tag값이 일치하는 Polyline을 찾는다.
 * @param tag 찾고자 하는 Polyline의 tag 값
 * @return tag값이 일치하는 Polyline 객체, 일치하는 Polyline이 없는 경우 nil이 리턴된다.
 */
- (MTMapPolyline*)findPolylineByTag:(NSInteger)tag;

/**
 * 특정 Polyline을 지도화면에서 제거한다.
 * @param polyline 제거하고자 하는 Polyline 객체
 */
- (void)removePolyline:(MTMapPolyline*)polyline;

/**
 * 지도 화면에 추가된 모든 Polyline을 제거한다.
 */
- (void)removeAllPolylines;

/**
 * 특정 Polyline의 모든 점들이 화면에 전부 나타나도록
 * 지도 화면 중심과 확대/축소 레벨을 자동으로 조정한다.
 * @param polyline 화면에 보여주고자 하는 polyline
 */
- (void)fitMapViewAreaToShowPolyline:(MTMapPolyline*)polyline;

/**
 * 지도 화면에 추가된 모든 Polyline 들이 
 * 화면에 나타나도록 지도 화면 중심과 확대/축소 레벨을 자동으로 조정한다.
 */
- (void)fitMapViewAreaToShowAllPolylines;

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// MTMapCircle

/**
 * 지도화면에 보여주고 있는 CircleOverlay 리스트를 조회할 수 있다.
 */
@property (nonatomic, readonly) NSArray* circles;

/**
 * 지도화면에 Circle을 추가한다.
 * @param circle 추가할 CircleOverlay 객체
 */
- (void)addCircle:(MTMapCircle*)circle;

/**
 * 지도화면에 추가된 Circle들 중에서 tag값이 일치하는 Circle를 찾는다.
 * @param tag 찾고자 하는 Circle의 tag 값
 * @return tag값이 일치하는 Circle 객체, 일치하는 Circle이 없는 경우 nil이 리턴된다.
 */
- (MTMapCircle*)findCircleByTag:(NSInteger)tag;

/**
 * 특정 Circle을 지도화면에서 제거한다.
 * @param circle 제거하고자 하는 CircleOverlay 객체
 */
- (void)removeCircle:(MTMapCircle*)circle;

/**
 * 지도 화면에 추가된 모든 Circle를 제거한다.
 */
- (void)removeAllCircles;

/**
 * 특정 Circle이 화면에 전부 나타나도록
 * 지도 화면 중심과 확대/축소 레벨을 자동으로 조정한다.
 * @param circle 화면에 보여주고자 하는 Circle
 */
- (void)fitMapViewAreaToShowCircle:(MTMapCircle*)circle;

/**
 * 지도 화면에 추가된 모든 Circle들이
 * 화면에 나타나도록 지도 화면 중심과 확대/축소 레벨을 자동으로 조정한다.
 */
- (void)fitMapViewAreaToShowAllCircleOverlays;

@end

/**
 * 지도 객체에서 발생하는 이벤트를 처리할 delegate interface protocol.
 * MTMapViewDelegate protocol을 구현한 객체를 생성하여 MTMapView 객체의 delegate property에 설정해야한다.
 * delegate 객체는 Open API Key 인증 결과 이벤트, 지도 이동/확대/축소,
 * 지도 화면 터치(Single Tap / Double Tap / Long Press) 이벤트,
 * 현위치 트래킹 이벤트, POI(Point Of Interest) 관련 이벤트를 통보받을 수 있다.
 * @see MTMapView
 */
@protocol MTMapViewDelegate <NSObject>
@optional

// Open API Key Authentication delegate methods

/**
 * [Open API Key Authentication] MTMapView 객체의 setDaumMapApiKey 메소드로 설정한 Open API Key값을
 * Daum Open API Key 인증 서버에 인증한 결과를 통보받을 수 있다.
 * Open API Key 는 App. Bundle Id 당 하나씩 Daum Open API Key 발급 페이지를 통해서 발급 된다.
 * @param mapView MTMapView 객체
 * @param resultCode 인증 결과 코드, 200 : 인증성공, 200이 아닌경우에는 인증 실패
 * @param resultMessage 인증 결과 메세지, 인증 성공 및 실패에 대한 구체적인 메세지를 제공함
 */
- (void)mapView:(MTMapView*)mapView openAPIKeyAuthenticationResultCode:(int)resultCode resultMessage:(NSString*)resultMessage;


// Map View Event delegate methods

/**
 * [Map View Event] 지도 중심 좌표가 이동한 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param mapCenterPoint 새로 이동한 지도 중심 좌표
 */
- (void)mapView:(MTMapView*)mapView centerPointMovedTo:(MTMapPoint*)mapCenterPoint;

/**
 * [Map View Event] 지도 화면의 이동이 끝난 뒤 호출된다.
 * @param mapView MTMapView 객체
 * @param mapCenterPoint 새로 이동한 지도 중심 좌표
 */
- (void)mapView:(MTMapView*)mapView finishedMapMoveAnimation:(MTMapPoint*)mapCenterPoint;

/**
 * [Map View Event] 지도 확대/축소 레벨이 변경된 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param zoomLevel 변경된 지도 확대/축소 레벨
 */
- (void)mapView:(MTMapView*)mapView zoomLevelChangedTo:(MTMapZoomLevel)zoomLevel;

/**
 * [Map View Event] 사용자가 지도 위를 터치한 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param mapPoint 사용자가 터치한 지도 좌표
 */
- (void)mapView:(MTMapView*)mapView singleTapOnMapPoint:(MTMapPoint*)mapPoint;

/**
 * [Map View Event] 사용자가 지도 위 한 지점을 더블 터치한 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param mapPoint 사용자가 터치한 지도 좌표
 */
- (void)mapView:(MTMapView*)mapView doubleTapOnMapPoint:(MTMapPoint*)mapPoint;

/**
 * [Map View Event] 사용자가 지도 위 한 지점을 터치하여 드래그를 시작할 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param mapPoint 사용자의 드래그가 시작한 지도 좌표
 */
- (void)mapView:(MTMapView*)mapView dragStartedOnMapPoint:(MTMapPoint*)mapPoint;

/**
 * [Map View Event] 사용자가 지도 위 한 지점을 터치하여 드래그를 끝낼 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param mapPoint 사용자의 드래그가 끝난 지도 좌표
 */
- (void)mapView:(MTMapView*)mapView dragEndedOnMapPoint:(MTMapPoint*)mapPoint;

/**
 * [Map View Event] 사용자가 지도 위 한 지점을 길게 누른 경우(long press) 호출된다.
 * @param mapView MTMapView 객체
 * @param mapPoint 사용자가 터치한 지도 좌표
 */
- (void)mapView:(MTMapView*)mapView longPressOnMapPoint:(MTMapPoint*)mapPoint;


// User Location Tracking delegate methods

/**
 * [User Location Tracking] 단말의 현위치 좌표값을 통보받을 수 있다.
 * MTMapView 클래스의 currentLocationTrackingMode property를 통해서
 * 사용자 현위치 트래킹 기능이 켜진 경우(MTMapCurrentLocationTrackingOnWithoutHeading, MTMapCurrentLocationTrackingOnWithHeading)
 * 단말의 위치에 해당하는 지도 좌표와 위치 정확도가 주기적으로 delegate 객체에 통보된다.
 * @param mapView MTMapView 객체
 * @param location 사용자 단말의 현재 위치 좌표
 * @param accuracy 현위치 좌표의 오차 반경(정확도) (meter)
 */
- (void)mapView:(MTMapView*)mapView updateCurrentLocation:(MTMapPoint*)location withAccuracy:(MTMapLocationAccuracy)accuracy;

/**
 * [User Location Tracking] 현위치를 얻고자 할때 실패한 경우 통보받을 수 있다.
 * MTMapView 클래스의 currentLocationTrackingMode property를 통해서
 * 사용자 현위치 트래킹 기능이 켜고자 했을 경우(MTMapCurrentLocationTrackingOnWithoutHeading, MTMapCurrentLocationTrackingOnWithHeading)
 * 위치 사용 권한이나 기타 다른 이유로 인해 오류가 발생했을 때 발생한다.
 * @param mapView MTMapView 객체
 * @param error 오류가 발생한 정보를 담고 있는 객체
 */
- (void)mapView:(MTMapView*)mapView failedUpdatingCurrentLocationWithError:(NSError *)error;

/**
 * [User Location Tracking] 단말의 방향(Heading) 각도값을 통보받을 수 있다.
 * MTMapView 클래스의 currentLocationTrackingMode property를 통해서
 * 사용자 현위치 트래킹과 나침반 모드가 켜진 경우(MTMapCurrentLocationTrackingOnWithHeading)
 * 단말의 방향 각도값이 주기적으로 delegate 객체에 통보된다.
 * @param mapView MTMapView 객체
 * @param headingAngle 사용자 단말의 방향 각도 값(degree)
 */
- (void)mapView:(MTMapView*)mapView updateDeviceHeading:(MTMapRotationAngle)headingAngle;

// POI(Point Of Interest) Item delegate methods

/**
 * [POI Item] 단말 사용자가 POI Item을 선택한 경우 호출된다.
 * 사용자가 MTMapView에 등록된 POI(Point Of Interest) Item 아이콘(마커)를 터치한 경우 호출된다.
 * MTMapViewDelegate protocol을 구현하는 delegate 객체의 구현의 리턴값(BOOL)에 따라
 * 해당 POI Item 선택 시, POI Item 마커 위에 말풍선(Callout Balloon)을 보여줄지 여부를 선택할 수 있다.
 * @param mapView MTMapView 객체
 * @param poiItem 선택된 POI Item 객체
 * @return POI Item 선택 시, 말풍선을 보여줄지 여부. YES:터치 시 말풍선이 나타남. NO:터치 시 말풍선이 나타나지 않음.
 * @see MTMapPOIItem
 */
- (BOOL)mapView:(MTMapView*)mapView selectedPOIItem:(MTMapPOIItem*)poiItem;

/**
 * [POI Item] 단말 사용자가 POI Item 아이콘(마커) 위에 나타난 말풍선(Callout Balloon)을 터치한 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param poiItem 말풍선이 터치된 POI Item 객체
 * @see MTMapPOIItem
 */
- (void)mapView:(MTMapView*)mapView touchedCalloutBalloonOfPOIItem:(MTMapPOIItem*)poiItem;

/**
 * [POI Item] 단말 사용자가 POI Item 아이콘(마커) 위에 나타난 말풍선(Callout Balloon)의 왼쪽 영역을 터치한 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param poiItem 말풍선이 터치된 POI Item 객체
 * @see MTMapPOIItem
 */
- (void)mapView:(MTMapView*)mapView touchedCalloutBalloonLeftSideOfPOIItem:(MTMapPOIItem*)poiItem;

/**
 * [POI Item] 단말 사용자가 POI Item 아이콘(마커) 위에 나타난 말풍선(Callout Balloon)의 오른쪽 영역을 터치한 경우 호출된다.
 * @param mapView MTMapView 객체
 * @param poiItem 말풍선이 터치된 POI Item 객체
 * @see MTMapPOIItem
 */
- (void)mapView:(MTMapView*)mapView touchedCalloutBalloonRightSideOfPOIItem:(MTMapPOIItem*)poiItem;

/**
 * [POI Item] 단말 사용자가 길게 누른후(long press) 끌어서(dragging) 위치 이동 가능한 POI Item의 위치를 이동시킨 경우 호출된다.
 * 이동가능한 POI Item을 Draggable POI Item이라 한다.
 * @param mapView MTMapView 객체
 * @param poiItem 새로운 위치로 이동된 Draggable POI Item 객체
 * @param newMapPoint 이동된 POI Item의 위치에 해당하는 지도 좌표
 * @see MTMapPOIItem
 */
- (void)mapView:(MTMapView*)mapView draggablePOIItem:(MTMapPOIItem*)poiItem movedToNewMapPoint:(MTMapPoint*)newMapPoint;
@end