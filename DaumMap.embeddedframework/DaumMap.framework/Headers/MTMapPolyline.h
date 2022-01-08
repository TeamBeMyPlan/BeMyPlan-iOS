/**
 * @brief Map Polyline Class
 * @file MTMapPolyline.h
 * @author Byung-Wan Lim (bwlim@daumcorp.com)
 * @date 2011/11/10
 * @copyright
 * Copyright 2012 Daum Communications Corp. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DaumMap/MTMapGeometry.h>

/**
 * @brief 지도도화면 위에 추가되는 Polyline에 해당하는 Class.
 * Polyline은 여러 개의 점들을 순서대로 연결한 선들의 집합이다.
 * 지도화면 위에 Polyline을 추가하여 경로나 영역등을 표현할 수 있다.
 * 지도화면 위에 Polyline을 추가하기 위해서는
 * MTMapPolyline 객체를 생성하여 MTMapView객체에 등록해 주어야 한다.
 * (MTMapView.addPolyline:)
 * Polyline을 구성하는 좌표 리스트를 설정하고 선 색상을 지정할 수 있다.
 * @see MTMapView
 */
@interface MTMapPolyline : NSObject {
@private
	NSMutableArray* _mapPointList;
	UIColor* _polylineColor;
	NSInteger _tag;
}

/**
 * MTMapPolyline 객체를 생성한다. autorelease 상태로 MTMapPolyline 객체를 생성하여 리턴한다.
 */
+ (instancetype)polyLine;

/**
 * MTMapPolyline 객체를 생성하고 Polyline을 구성하는 점들을 저장하는 Array의 크기를 미리 지정한다.
 * autorelease 상태로 MTMapPolyline 객체를 생성하여 리턴한다.
 * Polyline을 구성하는 점들의 개수를 미리 알수 있는 경우 capacity값을 지정하면 메모리를 효율적으로 사용할 수 있다.
 * @param capacity Polyline을 구성하는 점들의 좌표를 저장하는 Array의 메모리 할당 크기 (Polyline의 점 개수를 지정한다.)
 */
+ (instancetype)polyLineWithCapacity:(NSUInteger)capacity; // capacity : reserved map point array size

/**
 * Polyline을 구성하는 점들의 리스트를 조회할 수 있다.
 */
@property (nonatomic, readonly) NSArray* mapPointList;

/**
 * Polyline의 선 색상을 지정한다.
 */
@property (nonatomic, retain) UIColor* polylineColor;

/**
 * Polyline 객체에 임의의 정수값(tag)을 지정할 수 있다.
 * MTMapView에 등록된 Polyline들 중 특정 Polyline을 찾기 위한 식별자로 사용할 수 있다.
 * tag값을 반드시 지정해야 하는 것은 아니다.
 * @see MTMapView.findPolylineByTag:
 */
@property (nonatomic, assign) NSInteger tag;


/**
 * Polyline에 점 하나를 추가한다.
 * Polyline 객체가 MTMapView에 등록된 후에는 점들을 추가해도 지도화면에 반영되지 않는다.
 * @param mapPoint 추가하고자 하는 점의 좌표 객체
 */
- (void)addPoint:(MTMapPoint*)mapPoint;

/**
 * Polyline에 점 리스트를 추가한다.
 * Polyline 객체가 MTMapView 객체에 등록된 후에는 점들을 추가해도 지도화면에 반영되지 않는다.
 * @param mapPointList 추가하고자 하는 점들의 좌표 객체 리스트
 */
- (void)addPoints:(NSArray*)mapPointList; // Array of MTMapPoint

@end
