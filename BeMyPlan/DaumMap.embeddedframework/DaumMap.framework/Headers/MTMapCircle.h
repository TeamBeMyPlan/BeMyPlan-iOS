/**
 * @brief Map Circle Class
 * @file MTMapCircle.h
 * @author Soo-Hyun Park (goaeng0824@daumcorp.com)
 * @date 2014/6/11
 * @copyright
 * Copyright 2014 Daum Communications Corp. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DaumMap/MTMapGeometry.h>

/**
 * @brief 지도도화면 위에 추가되는 Circle에 해당하는 Class.
 * 지도화면 위에 Circle을 추가하기 위해서는
 * MTMapCircle 객체를 생성하여 MTMapView객체에 등록해 주어야 한다.
 * (MTMapView.addCircle:)
 * Circle의 중심점을 설정하고 선 색상, 선 두께, 영역 색깔, 반경을 지정할 수 있다.
 * @see MTMapView
 */
@interface MTMapCircle : NSObject {
@private
	MTMapPoint* _circleCenterPoint;
	float _circleLineWidth;
	UIColor* _circleLineColor;
	UIColor* _circleFillColor;
	float _circleRadius;
	NSInteger _tag;
}

/**
 * MTMapCircle 객체를 생성한다. autorelease 상태로 MTMapCircle 객체를 생성하여 리턴한다.
 */
+ (instancetype)circle;

/**
 * Circle의 중심점을 지정한다.
 */
@property (nonatomic, retain) MTMapPoint* circleCenterPoint;

/**
 * Circle의 선 두께를 지정한다.
 */
@property (nonatomic, assign) float circleLineWidth;

/**
 * Circle의 선 색상을 지정한다.
 */
@property (nonatomic, retain) UIColor* circleLineColor;

/**
 * Circle의 영역 색상을 지정한다.
 */
@property (nonatomic, retain) UIColor* circleFillColor;

/**
 * Circle의 반경 값을 지정한다.
 */
@property (nonatomic, assign) float circleRadius;

/**
 * Circle 객체에 임의의 정수값(tag)을 지정할 수 있다.
 * MTMapView에 등록된 Circle들 중 특정 Circle을 찾기 위한 식별자로 사용할 수 있다.
 * tag값을 반드시 지정해야 하는 것은 아니다.
 * @see MTMapView.findCircleByTag:
 */
@property (nonatomic, assign) NSInteger tag;

@end
