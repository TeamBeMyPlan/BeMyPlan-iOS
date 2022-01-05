/**
 * @brief Map POI Item Class
 * @file MTMapPOIItem.h
 * @author Byung-Wan Lim (bwlim@daumcorp.com)
 * @date 2011/11/10
 * @copyright
 * Copyright 2012 Daum Communications Corp. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <DaumMap/MTMapGeometry.h>

/**
 * POI Item 아이콘(마커) 타입 enumeration
 * @see MTMapPOIItem.markerType property
 */
typedef NS_ENUM(NSInteger, MTMapPOIItemMarkerType) {
	MTMapPOIItemMarkerTypeBluePin, /**< 파란색 핀 */
	MTMapPOIItemMarkerTypeRedPin, /**< 빨간색 핀 */
	MTMapPOIItemMarkerTypeYellowPin, /**< 노란색 핀 */
	MTMapPOIItemMarkerTypeCustomImage /**< 개발자가 지정한 POI Item 아이콘 이미지 사용 */
};

/**
 * POI Item 아이콘(마커)가 선택되어진 상태 타입 enumeration
 * @see MTMapPOIItem.markerSelectedType property
 */
typedef NS_ENUM(NSInteger, MTMapPOIItemMarkerSelectedType) {
    MTMapPOIItemMarkerSelectedTypeNone, /**< 선택 효과를 사용하지 않음 */
	MTMapPOIItemMarkerSelectedTypeBluePin, /**< 파란색 핀 */
	MTMapPOIItemMarkerSelectedTypeRedPin, /**< 빨간색 핀 */
	MTMapPOIItemMarkerSelectedTypeYellowPin, /**< 노란색 핀 */
	MTMapPOIItemMarkerSelectedTypeCustomImage /**< 개발자가 지정한 POI Item 아이콘 이미지 사용 */
};

/**
 * POI Item이 화면에 추가될때 애니매이션 타입 enumeration
 * @see MTMapPOIItem.showAnimationType property
 */
typedef NS_ENUM(NSInteger, MTMapPOIItemShowAnimationType) {
	MTMapPOIItemShowAnimationTypeNoAnimation, /**< 애니매이션 없음 */
	MTMapPOIItemShowAnimationTypeDropFromHeaven, /**< POI Item 아이콘이 하늘에서 지도 위로 떨어지는 애니매이션 */
	MTMapPOIItemShowAnimationTypeSpringFromGround /**< POI Item 아이콘이 땅위에서 스프링처럼 튀어나오는 듯한 애니매이션 */
};

/**
 * @brief 지도화면 위에 추가되는 POI(Point Of Interest) Item에 해당하는 Class.
 * 지도화면 위에 POI 아이콘(마커)를 추가하기 위해서는
 * MTMapPOIItem 객체를 생성하여 MTMapView객체에 등록해 주어야 한다. (MTMapView.addPOIItem:, MTMapView.addPOIItems:)
 * 이미 제공되고 있는 POI Item 아이콘을 그대로 사용할 수도 있고,
 * 개발자가 지정한 임의의 이미지를 POI Item 아이콘으로 사용할 수 있다.
 * MTMapView에 등록된 POI Item을 사용자가 선택하면
 * POI Item 아이콘(마커)위에 말풍선(Callout Balloon)이 나타나게 되며
 * 말풍선에는 POI Item 이름이 보여지게 된다.
 * 단말 사용자가 길게 누른후(long press) 끌어어(dragging) 위치를 이동시킬 수 있는
 * Draggable POI Item 도 생성하여 MTMapViewd에 등록할 수 있다.
 * @see MTMapView
 */
@interface MTMapPOIItem : NSObject {
@private
	NSString* _itemName;
	MTMapPoint* _mapPoint;
	MTMapPOIItemMarkerType _markerType;
    MTMapPOIItemMarkerSelectedType _markerSelectedType;
	MTMapPOIItemShowAnimationType _showAnimationType;
	BOOL _showDisclosureButtonOnCalloutBalloon;
	BOOL _draggable;
	NSInteger _tag;
	NSObject* _userObject;
	NSString* _customImageName;
    NSString* _customSelectedImageName;
	UIImage* _customImage;
	UIImage* _customSelectedImage;
	
    NSString* _imageNameOfCalloutBalloonLeftSide;
    NSString* _imageNameOfCalloutBalloonRightSide;
	MTMapImageOffset _customImageAnchorPointOffset;
    UIView* _customCalloutBalloonView;
    UIView* _customHighlightedCalloutBalloonView;
}

/**
 * MTMapPOIItem 객체를 생성한다. autorelease 상태로 MTMapPOIItem 객체를 생성하여 리턴한다.
 */
+ (instancetype)poiItem;

/**
 * POI Item 이름을 지정한다. 
 * POI Item 아이콘이 선택되면 나타나는 말풍선(Callout Balloon)에 POI Item 이름이 보여지게 된다.
 */
@property (nonatomic, copy) NSString* itemName;

/**
 * POI Item의 지도상 좌표
 */
@property (nonatomic, retain) MTMapPoint* mapPoint;

/**
 * POI Item 아이콘(마커) 타입
 * 기본 제공 POI Item 아이콘을 사용하거나,
 * 개발자가 지정한 임의의 이미지를 POI Item 아이콘으로 사용할 수 있다.
 * default = MTMapPOIItemMarkerTypeBluePin
 * @see MTMapPOIItemMarkerType
 */
@property (nonatomic, assign) MTMapPOIItemMarkerType markerType;

/**
 * POI Item 아이콘(마커)가 선택되어진 상태 타입
 * 기본 제공 POI Item 아이콘을 사용하거나,
 * 개발자가 지정한 임의의 이미지를 POI Item 아이콘으로 사용할 수 있다.
 * default = MTMapPOIItemMarkerTypeNone
 * @see MTMapPOIItemMarkerSelectedType
 */
@property (nonatomic, assign) MTMapPOIItemMarkerSelectedType markerSelectedType;

/**
 * POI Item이 지도화면에 나타날때 애니매이션 종류를 지정한다.
 * default = MTMapPOIItemShowAnimationTypeNoAnimation
 * @see MTMapPOIItemShowAnimationType
 */
@property (nonatomic, assign) MTMapPOIItemShowAnimationType showAnimationType;

/**
 * POI Item이 사용자에 의해 선택된 경우 나타나는 말풍선에 나타나는 글자 마지막에
 * Disclosure Button 이미지(꺽쇠(>)모양 이미지)를 표시할지 여부를 지정한다.
 * default = YES
 */
@property (nonatomic, assign) BOOL showDisclosureButtonOnCalloutBalloon;

/**
 * 사용자가 위치를 변경할 수 있는 POI Item을 생성하려면
 * draggable property를 YES로 지정한다.
 * draggable = YES인 POI Item(Draggable POI Item)을 사용자가 터치하면 POI Item을 사용자가 이동할 수 있음을 알려주는
 * 안내문구가 지도화면에 나타난다.
 * 사용자가 Draggable POI Item을 길게 누른 후(long press) 원하는 위치로 끌어서(dragging)
 * POI Item의 위치를 변경할 수 있다.
 * 변경된 POI Item의 위치는 MTMapViewDelegate.MTMapView:draggablePOIItem:movedToNewMapPoint: 메소드를 통해
 * 통보받을 수 있다.
 * default = NO
 * @see MTMapViewDelegate
 */
@property (nonatomic, assign) BOOL draggable;

/**
 * POI Item 객체에 임의의 정수값(tag)을 지정할 수 있다.
 * MTMapView 객체에 등록된 POI Item들 중 특정 POI Item을 찾기 위한 식별자로 사용할 수 있다.
 * tag값을 반드시 지정해야 하는 것은 아니다.
 * @see MTMapView.findPOIItemByTag:
 */
@property (nonatomic, assign) NSInteger tag;

/**
 * 해당 POI Item과 관련된 정보를 저장하고 있는 임의의 객체를 저장하고자 할때 사용한다.
 * 사용자가 POI Item을 선택하는 경우 등에 선택된 POI Item과 관련된 정보를 손쉽게 접근할 수 있다.
 */
@property (nonatomic, retain) NSObject* userObject;

/**
 * markerType이 MTMapPOIItemMarkerTypeCustomImage인 경우에만 지정한다.
 * 기본 제공되는 POI Item 아이콘 이미지를 사용하지 않고, 개발자가 지정한 Custom 이미지를 사용하고자 하는 경우에
 * 사용하고자 하는 Image 이름을 지정한다. Application Bundle에 포함된 
 * Image Resource 이름(ex. "MyPOIIconImage.png")을 지정할 수 있다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 * @see MTMapPOIItemMarkerTypeCustomImage
 */
@property (nonatomic, copy) NSString* customImageName;

/**
 * markerType이 MTMapPOIItemMarkerSelectedTypeCustomImage인 경우에만 지정한다.
 * 개발자가 지정한 Custom 이미지를 사용하고 있는 POI Item 아이콘(마커)이 선택되었을 경우에
 * 사용하고자 하는 Image 이름을 지정한다. Application Bundle에 포함된
 * Image Resource 이름(ex. "MyPOIIconImage.png")을 지정할 수 있다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 * @see MTMapPOIItemMarkerTypeCustomImage
 */
@property (nonatomic, copy) NSString* customSelectedImageName;

/**
 * markerType이 MTMapPOIItemMarkerTypeCustomImage인 경우에만 지정한다.
 * 기본 제공되는 POI Item 아이콘 이미지를 사용하지 않고, 개발자가 지정한 Custom 이미지를 사용하고자 하는 경우에
 * 사용하고자 하는 Runtime 시에 생성한 이미지의 UIImage 객체를 지정한다.
 * customImageName에 값이 지정되어 있는 경우는 customImageName의 값이 우선 적용 된다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 * @see MTMapPOIItemMarkerTypeCustomImage
 */
@property (nonatomic, copy) UIImage* customImage;

/**
 * markerType이 MTMapPOIItemMarkerSelectedTypeCustomImage인 경우에만 지정한다.
 * 개발자가 지정한 Custom 이미지를 사용하고 있는 POI Item 아이콘(마커)이 선택되었을 경우에
 * 사용하고자 하는 Runtime 시에 생성한 이미지의 UIImage 객체를 지정한다.
 * customSelectedImageName에 값이 지정되어 있는 경우는 customSelectedImageName의 값이 우선 적용 된다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 * @see MTMapPOIItemMarkerTypeCustomImage
 */
@property (nonatomic, copy) UIImage* customSelectedImage;

/**
 * POI Item이 사용자에 의해 선택된 경우 나타나는 말풍선의 왼쪽 끝에
 * 사용하고자 하는 Image 이름을 지정한다. Application Bundle에 포함된
 * Image Resource 이름(ex. "MyPOIIconImage.png")을 지정할 수 있다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 */
@property (nonatomic, copy) NSString* imageNameOfCalloutBalloonLeftSide;

/**
 * POI Item이 사용자에 의해 선택된 경우 나타나는 말풍선의 오른쪽 끝에
 * 사용하고자 하는 Image 이름을 지정한다. Application Bundle에 포함된
 * Image Resource 이름(ex. "MyPOIIconImage.png")을 지정할 수 있다.
 * Custom Image는 Screen Scale = 2.0(Retina Display)에 대응하는 고해상도 이미지를 지정해야 한다.
 */
@property (nonatomic, copy) NSString* imageNameOfCalloutBalloonRightSide;

/**
 * markerType이 MTMapPOIItemMarkerTypeCustomImage인 경우에만 지정한다.
 * customImageName에 지정한 이미지 상의 어느 지점이 POI Item의 좌표 지점에 해당하는 지를 설정한다.
 * 이미지 상의 Pixel 좌표를 지정한다. 이미지의 좌하단이 원점(0,0)이고 오른쪽 방향이 x+축, 위쪽 방향이 y+축이 된다.
 * 예를들어, 이미지의 pixel 크기가 60x60인 Custom Image의 
 * 하단 변(edge)의 정중앙이 POI Item 좌표 지점에 해당된다면
 * mapView.customImageAnchorPointOffset = MTMapImageOffsetMake(30,0) 와 같이 지정할 수 있다.
 * 값을 지정하지 않는 경우 이미지의 하단 중앙이 Anchor Point로 설정된다.
 * @see MTMapPOIItemMarkerTypeCustomImage
 */
@property (nonatomic, assign) MTMapImageOffset customImageAnchorPointOffset;

/**
 * POI Item이 사용자에 의해 선택된 경우 나타나는 말풍선 대신
 * Custom View를 지정할 수 있다.
 * @see customHighlightedCalloutBalloonView
 */
@property (nonatomic, retain) UIView* customCalloutBalloonView;

/**
 * POI Item이 사용자에 의해 선택된 경우 나타나는 말풍선 대신
 * Custom View를 사용할 경우에만 지정한다.
 * Custom View가 선택되어진 상태일 때의 View를 
 * 별도로 지정할 수 있다.
 * @see customCalloutBalloonView
 */
@property (nonatomic, retain) UIView* customHighlightedCalloutBalloonView;

/**
 * POI Item이 나타내는 Marker의 회전 각을 지정 한다.
 * 각도는 0~360의 값을 지정하면 된다.
 */
@property (nonatomic, assign) float rotation;


- (void) move:(MTMapPoint*)pt withAnimation:(BOOL)animate;


@end
