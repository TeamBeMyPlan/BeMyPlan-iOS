/**
 * @brief Daum Map Geometry Data Types
 * @file MTMapGeometry.h
 * @author Byung-Wan Lim (bwlim@daumcorp.com)
 * @date 2011/11/04
 * @copyright
 * Copyright 2012 Daum Communications Corp. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * Geoid 타원체 상의 한 점을 표현하는 지도 좌표 타입 (WGS84)
 * 위도(latitude)와 경도(longitude)값으로 구성된다.
 */
typedef struct {
	double latitude; /**< 위도 값 */
	double longitude; /**< 경도 값 */
} MTMapPointGeo;

/**
 * 위도 경도 값으로 MTMapPointGeo 데이터 구조를 생성하는 매크로
 * @param latitude 위도 값
 * @param longitude 경도 값
 * @return MTMapPointGeo 데이터 구조
 */
#define MTMapPointGeoMake(latitude,longitude) (MTMapPointGeo){(double)latitude, (double)longitude}

/**
 * Geoid 상의 구면 좌표를 평면으로 프로젝션한 지도 좌표 정보를 저장하는 데이터 구조
 * 평면 좌표 체계로는 WCONG(Daum), CONG(Daum), WTM 등이 있다.
 */
typedef struct {
	double x; /**< x 좌표값 */
	double y; /**< y 좌표값 */
} MTMapPointPlain;

/**
 * x, y 좌표 값으로 MTMapPointPlain 데이터 구조를 생성하는 매크로
 * @param x x 좌표값
 * @param y y 좌표값
 * @return MTMapPointGeo 데이터 구조
 */
#define MTMapPointPlainMake(x,y) (MTMapPointPlain){(double)x, (double)y}

@class InternalCoord; // internal class processing map coordinates

/**
 * @brief 지도 화면위 한 지점을 표현할 수 있는 Point Class.
 * 지도 화면 위의 위치와 관련된 작업을 처리할 때 항상 MTMapPoint 객체를 사용한다.
 * MTMapPoint 객체는 위경도값(WGS84)을 이용하여 생성하거나,
 * 평면 좌표값(WCONG(Daum), WTM)을 이용하여 생성할 수 있다.
 * 특정 좌표시스템의 좌표를 이용하여 MTMapPoint객체를 생성한 후에 
 * mapPointGeo:, mapPointWCONG, mapPointWTM등의 메소드를 통해 
 * 다른 좌표 시스템의 좌표값으로 손쉽게 조회해 볼 수 있다.
 */
@interface MTMapPoint : NSObject {
@private
	InternalCoord* _internalCoord;
}

/**
 * 위경도 좌표 시스템(WGS84)의 좌표값으로 MTMapPoint 객체를 생성한다.
 * @param mapPointGeo 위경도 좌표 시스템(WGS84)의 좌표값
 * @return MTMapPoint 객체
 */
+ (instancetype)mapPointWithGeoCoord:(MTMapPointGeo)mapPointGeo;

/**
 * WCONG(Daum) 평면 좌표시스템의 좌표값으로 MTMapPoint 객체를 생성한다.
 * @param mapPointWCONG WCONG(Daum) 평면 좌표시스템의 좌표값
 * @return MTMapPoint 객체
 */
+ (instancetype)mapPointWithWCONG:(MTMapPointPlain)mapPointWCONG;

/**
 * CONG(Daum) 평면 좌표시스템의 좌표값으로 MTMapPoint 객체를 생성한다.
 * @param mapPointCONG CONG(Daum) 평면 좌표시스템의 좌표값
 * @return MTMapPoint 객체
 */
+ (instancetype)mapPointWithCONG:(MTMapPointPlain)mapPointCONG;

/**
 * WTM 평면 좌표시스템의 좌표값으로 MTMapPoint 객체를 생성한다.
 * @param mapPointWTM WCONG(Daum) WTM 평면 좌표시스템의 좌표값
 * @return MTMapPoint 객체
 */
+ (instancetype)mapPointWithWTM:(MTMapPointPlain)mapPointWTM;

/**
 * MapView의 좌상단 기준 Pixel 좌표값으로 MTMapPoint 객체를 생성한다.
 * @param mapPointScreenLocation Pixel 좌표시스템의 좌표값
 * @return MTMapPoint 객체
 */
+ (instancetype)mapPointWithScreenLocation:(MTMapPointPlain)mapPointScreenLocation;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 위경도 좌표시스템(WGS84)의 좌표값으로 조회한다.
 * @return 위경도 좌표시스템(WGS84)의 좌표값
 */
- (MTMapPointGeo)mapPointGeo;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 위경도 좌표시스템(WGS84)의 좌표값을 이용하여 재설정한다.
 * @param mapPointGeo 위경도 좌표시스템(WGS84)의 좌표값
 */
- (void)setMapPointGeo:(MTMapPointGeo)mapPointGeo;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 WCONG(Daum) 평면좌표계의 좌표값으로 조회한다.
 * @return WCONG(Daum) 평면좌표계의 좌표값
 */
- (MTMapPointPlain)mapPointWCONG;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 WCONG(Daum) 평면좌표계의 좌표값을 이용하여 재설정한다.
 * @param mapPointWCONG WCONG(Daum) 평면좌표계의 좌표값
 */
- (void)setMapPointWCONG:(MTMapPointPlain)mapPointWCONG;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 CONG(Daum) 평면좌표계의 좌표값으로 조회한다.
 * @return CONG(Daum) 평면좌표계의 좌표값
 */
- (MTMapPointPlain)mapPointCONG;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 CONG(Daum) 평면좌표계의 좌표값을 이용하여 재설정한다.
 * @param mapPointCONG CONG(Daum) 평면좌표계의 좌표값
 */
- (void)setMapPointCONG:(MTMapPointPlain)mapPointCONG;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 WTM 평면좌표계의 좌표값으로 조회한다.
 * @return WCONG(Daum) WTM 평면좌표계의 좌표값
 */
- (MTMapPointPlain)mapPointWTM;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 WTM 평면좌표계의 좌표값을 이용하여 재설정한다.
 * @param mapPointWTM WTM 평면좌표계의 좌표값
 */
- (void)setMapPointWTM:(MTMapPointPlain)mapPointWTM;

/**
 * MTMapPoint 객체가 나타내는 지점의 좌표값을 WTM 평면좌표계의 좌표값으로 조회한다.
 * @return MapView 좌상단 기준 Pixel 좌표값
 */
- (MTMapPointPlain)mapPointScreenLocation;

@end

/**
 * 지도 화면의 영역을 표현하는 데이터 구조
 * 영역의 좌하단 지점과 우상단 지점을 각각 MTMapPoint 타입의 인자로 갖는다.
 * @deprecated 제거될 예정. MTMapBoundsRect 클래스를 사용하세요.
 */
typedef struct {
    __unsafe_unretained MTMapPoint* bottoomLeft; /**< 영역의 좌하단 좌표 */
    __unsafe_unretained MTMapPoint* topRight; /**< 영역의 우상단 좌표 */
} MTMapBounds;

/**
 * 영역의 좌하단 좌표값과 우상단 좌표값으로 MTMapBounds 데이터 구조를 생성하는 매크로
 * @deprecated 제거될 예정. MTMapBoundsRect 클래스를 사용하세요.
 * @param bottoomLeft 영역의 좌하단 좌표
 * @param topRight 영역의 우상단 좌표
 * @return MTMapBounds 데이터 구조
 */
#define MTMapBoundsMake(bottoomLeft,topRight) (MTMapBounds){(MTMapPoint *)bottoomLeft, (MTMapPoint *)topRight}

/**
 * @brief 지도 화면의 영역을 표현하는 BoundsRect Class.
 * 영역의 좌하단 지점과 우상단 지점을 각각 MTMapPoint 타입의 인자로 갖는다.
 */
@interface MTMapBoundsRect : NSObject

/**
 * MTMapBoundsRect 객체를 생성한다. autorelease 상태로 MTMapBoundsRect 객체를 생성하여 리턴한다.
 */

+ (instancetype)boundsRect;

/**
 * 영역의 좌하단 좌표
 */
@property (nonatomic, retain) MTMapPoint *bottomLeft;

/**
 * 영역의 우상단 좌표
 */
@property (nonatomic, retain) MTMapPoint *topRight;

@end

/**
 * 이미지 상의 한 픽셀의 위치를 표현하는 데이터 구조
 * 이미지의 좌하단이 offset (0,0)이 되고 오른쪽 방향이 x+ 위쪽 방향이 y+ 가 된다.
 * @see MTMapPOIItem.customImageAnchorPointOffset
 */
typedef struct {
	int offsetX; /**< x 픽셀 좌표 */
	int offsetY; /**< y 픽셀 좌표 */
} MTMapImageOffset;

/**
 * 현위치 정확도를 나타내는 데이터 타입 (단위:meter)
 */
typedef double MTMapLocationAccuracy;

/**
 * 지도 회전 각도를 나타내는 데이터 타입 (단위:degree)
 */
typedef float MTMapRotationAngle;

/**
 * x/y offset 값으로 MTMapImageOffset 데이터 구조를 생성하는 매크로
 * @param offsetX x offset 값
 * @param offsetY y offset 값
 * @return MTMapImageOffset 데이터 구조
 */
#define MTMapImageOffsetMake(offsetX, offsetY) (MTMapImageOffset){(int)offsetX, (int)offsetY}
