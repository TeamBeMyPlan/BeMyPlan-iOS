/**
 * @brief Map Location Marker Item Class
 * @file MTMapLocationMarkerItem.h
 * @author Soo-hyun Park (goaeng0824@daumcorp.com)
 * @date 2014/6/16
 * @copyright
 * Copyright 2014 Daum Communications Corp. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DaumMap/MTMapGeometry.h>

/**
 * @brief 지도화면 위에 추가되는 현위치 마커 Item에 해당하는 Class.
 * 지도화면 위의 현위치 마커를 개발자가 원하는 UI로 바꿔주기 위해서는
 * MTMapLocationMarkerItem 객체를 생성하여 MTMapView 객체에 등록해 주어야 한다. (updateCurrentLocationMarker:)
 * Default로 제공되는 현위치 마커를 사용하기 위해서는
 * MTMapLocationMarkerItem 객체의 값을 nil로 넘겨준다.
 * @see MTMapView
 */

@interface MTMapLocationMarkerItem : NSObject {
@private
    NSString* _customImageName;
    NSString* _customTrackingImageName;
    NSArray* _customTrackingAnimationImageNames;
    float _customTrackingAnimationDuration;
    NSString* _customDirectionImageName;
    MTMapImageOffset _customImageAnchorPointOffset;
    MTMapImageOffset _customTrackingImageAnchorPointOffset;
    MTMapImageOffset _customDirectionImageAnchorPointOffset;
    float _radius;
    UIColor *_strokeColor;
    UIColor *_fillColor;
}

/**
 * MTMapLocationMarkerItem 객체를 생성한다. autorelease 상태로 MTMapLocationMarkerItem 객체를 생성하여 리턴한다.
 */

+ (instancetype)mapLocationMarkerItem;

/**
 * 기본 제공되는 Map Location Marker 아이콘 이미지를 사용하지 않고, 개발자가 지정한 Custom 이미지를 사용하고자 하는 경우에
 * 사용하고자 하는 Image 이름을 지정한다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 */
@property (nonatomic, copy) NSString* customImageName;

/**
 * 기본 제공되는 Map Location Marker의 Tracking 중인 아이콘 이미지를 사용하지 않고, 개발자가 지정한 Custom 이미지를 사용하고자 하는 경우에
 * 사용하고자 하는 Image 이름을 지정한다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 */
@property (nonatomic, copy) NSString* customTrackingImageName;

/**
 * 기본 제공되는 Map Location Marker의 Tracking 중인 아이콘 이미지를 사용하지 않고, 개발자가 지정한 Custom 이미지들로 애니매이션을 보여주고 싶은 경우
 * 애니매이션에 사용하고자 하는 Image 이름들을 순서대로 지정한다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 */
@property (nonatomic, copy) NSArray* customTrackingAnimationImageNames;

/**
 * 기본 제공되는 Map Location Marker의 Tracking 중인 아이콘 이미지를 사용하지 않고, 개발자가 지정한 Custom 이미지들로 애니매이션을 보여주고 싶은 경우
 * 애니매이션의 duration을 지정한다. default = 1.0 초
 */
@property (nonatomic, assign) float customTrackingAnimationDuration;

/**
 * 기본 제공되는 Map Location Marker의 방향 이미지를 사용하지 않고, 개발자가 지정한 Custom 이미지를 사용하고자 하는 경우에
 * 사용하고자 하는 Image 이름을 지정한다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 */
@property (nonatomic, copy) NSString* customDirectionImageName;

/**
 * customImageName에 지정한 이미지 상의 어느 지점이 현위치 지점에 해당하는 지를 설정한다.
 * 이미지 상의 Pixel 좌표를 지정한다. 이미지의 좌하단이 원점(0,0)이고 오른쪽 방향이 x+축, 위쪽 방향이 y+축이 된다.
 * 예를들어, 이미지의 pixel 크기가 60x60인 Custom Image의
 * 정중앙이 현위치 좌표 지점에 해당된다면
 * mapView.customImageAnchorPointOffset = MTMapImageOffsetMake(30,30) 와 같이 지정할 수 있다.
 * 값을 지정하지 않는 경우 이미지의 중앙이 Anchor Point로 설정된다.
 */
@property (nonatomic, assign) MTMapImageOffset customImageAnchorPointOffset;

/**
 * customImageName에 지정한 이미지 상의 어느 지점이 현위치 지점에 해당하는 지를 설정한다.
 * 이미지 상의 Pixel 좌표를 지정한다. 이미지의 좌하단이 원점(0,0)이고 오른쪽 방향이 x+축, 위쪽 방향이 y+축이 된다.
 * 예를들어, 이미지의 pixel 크기가 60x60인 Custom Image의
 * 정중앙이 현위치 좌표 지점에 해당된다면
 * mapView.customTrackingImageAnchorPointOffset = MTMapImageOffsetMake(30,30) 와 같이 지정할 수 있다.
 * 값을 지정하지 않는 경우 이미지의 중앙이 Anchor Point로 설정된다.
 */
@property (nonatomic, assign) MTMapImageOffset customTrackingImageAnchorPointOffset;

/**
 * customImageName에 지정한 이미지 상의 어느 지점이 현위치 지점에 해당하는 지를 설정한다.
 * 이미지 상의 Pixel 좌표를 지정한다. 이미지의 좌하단이 원점(0,0)이고 오른쪽 방향이 x+축, 위쪽 방향이 y+축이 된다.
 * 예를들어, 이미지의 pixel 크기가 60x60인 Custom Image의
 * 하단 변(edge)의 정중앙이 좌표 지점에 해당된다면
 * mapView.customTrackingImageAnchorPointOffset = MTMapImageOffsetMake(30,0) 와 같이 지정할 수 있다.
 * 값을 지정하지 않는 경우 이미지의 하단 중앙이 Anchor Point로 설정된다.
 */
@property (nonatomic, assign) MTMapImageOffset customDirectionImageAnchorPointOffset;

/**
 * 기본 제공되는 Map Location Marker의 Circle 반경 값을 지정한다.
 */
@property (nonatomic, assign) float radius;

/**
 * 기본 제공되는 Map Location Marker의 Circle 선 색상을 지정한다.
 */
@property (nonatomic, retain) UIColor* strokeColor;

/**
 * 기본 제공되는 Map Location Marker의 Circle 영역 색상을 지정한다.
 */
@property (nonatomic, retain) UIColor* fillColor;

@end
