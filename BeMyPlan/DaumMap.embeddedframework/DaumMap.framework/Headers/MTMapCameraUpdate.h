/**
 * @brief Map CameraUpdate Class
 * @file MTMapCameraUpdate.h
 * @author Soo-Hyun Park (goaeng0824@daumcorp.com)
 * @date 2014/7/16
 * @copyright
 * Copyright 2014 Daum Communications Corp. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DaumMap/MTMapGeometry.h>
#import <DaumMap/MTMapView.h>


/**
 * @brief 지도 화면 처리를 담당하는 Class
 * 지도 화면 이동/확대/축소 등의 기능이 제공된다.
 * @see MTMapView
 */

@interface MTMapCameraUpdate : NSObject

/**
 * 지도 화면을 현재의 확대/축소 레벨을 유지한 상태로
 * 설정한 중심점으로 이동한다.
 * @param mapPoint 이동하는 지도 화면의 중심점
 */

+ (MTMapCameraUpdate *)move:(MTMapPoint *)mapPoint;

/**
 * 지도 화면을 설정한 확대/축소 레벨로 조정 및
 * 설정한 중심점으로 이동한다.
 * @param mapPoint 이동하는 지도 화면의 중심점
 * @param zoomLevel 변경된 지도 확대/축소 레벨
 */

+ (MTMapCameraUpdate *)move:(MTMapPoint *)mapPoint withZoomLevel:(MTMapZoomLevel)zoomLevel;

/**
 * 설정한 중심점으로 이동하면서 지정한 직경(meter) 영역이 보이도록 줌레벨이 조정된다.
 * 지정한 영역의 padding 값은 0
 * @param mapPoint 이동하는 지도 화면의 중심점
 * @param meter 직경(지름)
 */

+ (MTMapCameraUpdate *)move:(MTMapPoint *)mapPoint withDiameter:(CGFloat)meter;

/**
 * 설정한 중심점으로 이동하면서 지정한 직경(meter) 영역이 보이도록 줌레벨이 조정된다.
 * @param mapPoint 이동하는 지도 화면의 중심점
 * @param meter 직경(지름)
 * @param padding 지정한 영역의 padding 값
 */

+ (MTMapCameraUpdate *)move:(MTMapPoint *)mapPoint withDiameter:(CGFloat)meter withPadding:(CGFloat)padding;

/**
 * 지정한 영역이 화면에 나타나도록 지도화면 중심과 확대/축소 레벨을 자동조절한다.
 * 지정한 영역의 padding 값은 0
 * @deprecated 제거될 예정. fitMapViewWithMapBounds: 를 사용하세요.
 * @param bounds 화면에 보여주고자 하는 영역 (MTMapPoint 타입의 좌하단 지점과 우상단 지점을 인자로 갖는 구조체)
 */

+ (MTMapCameraUpdate *)fitMapView:(MTMapBounds)bounds;

/**
 * padding 값을 반영한 지정한 영역이 화면에 지정된 나타나도록 지도화면 중심과 확대/축소 레벨을 자동조절한다.
 * @deprecated 제거될 예정. fitMapViewWithMapBounds:withPadding: 를 사용하세요.
 * @param bounds 화면에 보여주고자 하는 영역 (MTMapPoint 타입의 좌하단 지점과 우상단 지점을 인자로 갖는 구조체)
 * @param padding 지정한 영역의 padding 값
 */

+ (MTMapCameraUpdate *)fitMapView:(MTMapBounds)bounds withPadding:(CGFloat)padding;

/**
 * padding 값을 반영한 지정한 영역이 화면에 지정된 나타나도록 하되
 * 지정한 최소 레벨과 최대 레벨 범위 안의 지도화면 중심과 확대/축소 레벨을 자동조절 한다.
 * @deprecated 제거될 예정. fitMapViewWithMapBounds:withPadding:withMinZoomLevel:withMaxZoomLevel: 를 사용하세요.
 * @param bounds 화면에 보여주고자 하는 영역 (MTMapPoint 타입의 좌하단 지점과 우상단 지점을 인자로 갖는 구조체)
 * @param padding 지정한 영역의 padding 값
 * @param minZoomLevel 지도 화면 최대 확대 레벨 값 (-2~12, 값이 작을수록 더 좁은 영역이 화면이 보임. 지도 화면이 확대됨)
 * @param maxZoomLevel 지도 화면 최대 축소 레벨 값 (-2~12, 값이 클수록 더 넓은 영역이 화면이 보임. 지도 화면이 축소됨)
 */

+ (MTMapCameraUpdate *)fitMapView:(MTMapBounds)bounds withPadding:(CGFloat)padding withMinZoomLevel:(MTMapZoomLevel)minZoomLevel withMaxZoomLevel:(MTMapZoomLevel)maxZoomLevel;

/**
 * 지정한 영역이 화면에 나타나도록 지도화면 중심과 확대/축소 레벨을 자동조절한다.
 * 지정한 영역의 padding 값은 0
 * @param bounds 화면에 보여주고자 하는 영역 (MTMapPoint 타입의 좌하단 지점과 우상단 지점을 인자로 갖는 구조체)
 */

+ (MTMapCameraUpdate *)fitMapViewWithMapBounds:(MTMapBoundsRect *)bounds;

/**
 * padding 값을 반영한 지정한 영역이 화면에 지정된 나타나도록 지도화면 중심과 확대/축소 레벨을 자동조절한다.
 * @param bounds 화면에 보여주고자 하는 영역 (MTMapPoint 타입의 좌하단 지점과 우상단 지점을 인자로 갖는 구조체)
 * @param padding 지정한 영역의 padding 값
 */

+ (MTMapCameraUpdate *)fitMapViewWithMapBounds:(MTMapBoundsRect *)bounds withPadding:(CGFloat)padding;

/**
 * padding 값을 반영한 지정한 영역이 화면에 지정된 나타나도록 하되
 * 지정한 최소 레벨과 최대 레벨 범위 안의 지도화면 중심과 확대/축소 레벨을 자동조절 한다.
 * @param bounds 화면에 보여주고자 하는 영역 (MTMapPoint 타입의 좌하단 지점과 우상단 지점을 인자로 갖는 구조체)
 * @param padding 지정한 영역의 padding 값
 * @param minZoomLevel 지도 화면 최대 확대 레벨 값 (-2~12, 값이 작을수록 더 좁은 영역이 화면이 보임. 지도 화면이 확대됨)
 * @param maxZoomLevel 지도 화면 최대 축소 레벨 값 (-2~12, 값이 클수록 더 넓은 영역이 화면이 보임. 지도 화면이 축소됨)
 */

+ (MTMapCameraUpdate *)fitMapViewWithMapBounds:(MTMapBoundsRect *)bounds withPadding:(CGFloat)padding withMinZoomLevel:(MTMapZoomLevel)minZoomLevel withMaxZoomLevel:(MTMapZoomLevel)maxZoomLevel;

@end




