//
//  MainCardCarouselLayout.swift
//  BeMyPlan
//
//  Created by 안현주 on 2022/01/10.
//
// 사용자가 컬렉션 뷰를 스크롤할 때 컬렉션 뷰의 가운데 축을 중심으로 cell들이 offset 된 거리의 만큼을 비율 값으로 계산하여 스케일 값과 투명도를 조정하는 겁니다.

import Foundation
import UIKit

class MainCardCarouselLayout: UICollectionViewFlowLayout {
  public var sideItemScale: CGFloat = 0.5
  public var sideItemAlpha: CGFloat = 0.5
  public var spacing: CGFloat = 10
  
  public var isPagingEnabled: Bool = false
  
  private var isSetup: Bool = false
  
  // MARK: prepare는 사용자가 스크롤 시 매번 호출된다고 한다. setupLayout()은 초기에 한 번만 호출되도록 한 것이다.
  override public func prepare() {
    super.prepare()
    if isSetup == false {
      setupLayout()
      isSetup = true
    }
  }
  
  //3D하게 될 경우 고쳐야할 코드
  private func setupLayout() {
    guard let collectionView = self.collectionView else {return}
    
    let collectionViewSize = collectionView.bounds.size
    
    let xInset = (collectionViewSize.width - self.itemSize.width) / 2
    let yInset = (collectionViewSize.height - self.itemSize.height) / 2
    
    self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
    
    let itemWidth = self.itemSize.width
    
    //변경전
    //    let scaledItemOffset =  (itemWidth - itemWidth*self.sideItemScale) / 2
    //    self.minimumLineSpacing = spacing - scaledItemOffset
    //여기까지
    
    //변경 후
    let scaledItemOffset =  (itemWidth - (itemWidth*(self.sideItemScale + (1 - self.sideItemScale)/2))) / 2
    print(scaledItemOffset)
    self.minimumLineSpacing = spacing - scaledItemOffset
    
    
    self.scrollDirection = .horizontal
  }
  
  public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  /// 모든 셀과 뷰에 대한 속성을 UICollectionViewLayoutAttributes의 배열로 반환해준다고 한다.
  /// 이 속성들을 사용하기 위해 map 함수를 통해 리턴해주었다.
  public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let superAttributes = super.layoutAttributesForElements(in: rect),
          let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
    else { return nil }
    
    /// transformLayoutAttributes() 함수를 이용해 기존 attributes 속성들을 원하는 대로 변환하고
    /// 이를 attributes에 다시 매핑하여 UICollectionViewLayoutAttributes로 반환한다
    return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
  }
  
  
  //3D 할 경우 수정 해야할 코드
  private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    
    guard let collectionView = self.collectionView else {return attributes}
    
    // 순서대로 컬렉션뷰 크기의 절반, 컬렉션뷰의 컨텐트의 x좌표:예를 들어 한 셀이 지나면 셀의 크기만큼 더해진다, 현재 컨텐트의 오프셋과 각 셀의 중심 좌표의 차이다 : 이는 컬렉션뷰의 오리진 x좌표와 셀의 중심 사이의 거리라고 볼 수 있다.
    // 즉, center는 컬렉션뷰 좌표계를 기준으로 각 셀의 중심의 x표이다.
    let collectionCenter = collectionView.frame.size.width / 2
    let contentOffset = collectionView.contentOffset.x
    let center = attributes.center.x - contentOffset
    
    // 멀리 있는 경우, ratio가 0이 되며 sideItem으로 판별하여 alpha와 scale이 된다.
    // maxDistance보다 가까운 경우, ratio가 1에 가까워지면서 alpha와 scale 값이 1로 온전해진다.
    // distance의 경우, 컬렉션뷰 중심과 각 셀의 중심 사이의 거리이다. 컬렉션뷰 중심으로 셀이 가까이 올수록 거리가 줄어든다. maxdistance를 넣은 이유는 ratio가 음수가 되는 것을 방지하기 위해서이다.
    let maxDistance = self.itemSize.width + self.minimumLineSpacing
    let distance = min(abs(collectionCenter - center), maxDistance)
    
    let ratio = (maxDistance - distance)/maxDistance
    
    // 아래에 있는 1을 바꿔서 중심으로 올수록 흐려지거나, 작게 만들 수 있다.
    let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
    let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
    
    attributes.alpha = alpha
    
    
    //3D 효과 넣을 때 생긴 코드
//    if abs(collectionCenter - center) > maxDistance + 1 {
//      attributes.alpha = 0
//    }
    
    ///1차로 준호 코드에서 새로 생긴거///
//    // fakescale은 중심에서 -1, 멀어졌을 때 1
//    var fakescale = (492/520-scale)*(520/28)
//    // realscale은 중심에서 0, 멀어졌을 때 -1
//    var realscale = (-1-fakescale)*0.5
//    print(realscale)
    
    
    
    
    let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
    let dist = attributes.frame.midX - visibleRect.midX
    var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
    
    // 1이 한 바퀴 회전이다. 360도임
    // CATransform은 한 번에 하나씩만 사용 가능하다.
    //        transform = CATransform3DMakeRotation(realscale*8, 0, 1, 0)
    
    // 마지막 인자는 z좌표이고, 각 셀이 어떤 셀의 위에 있을지 아닐지를 결정한다. 아래 코드는 거리가 멀수록 화면에서 뒤로 가게끔 만든다(우리가 화면을 바라본다고 가정할 때). +값이라면 우리 눈 앞으로 다가오는 것이다.
    transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
    attributes.transform3D = transform
    
    return attributes
  }
  
  
  
  // MARK: 페이징 가능하게 해주는 코드
  //3D에서 새로 생긴 기능
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    
    //입력 파라미터가 proposedContentOffset, velocity 2가지가 있다
    //1. proposedContentOffset - 스크롤이 자연스럽게 중지 되는 값, point는 visable content의 좌측 위 모서리를 가리킵니다.(visible content는 collectionView bounds의 좌측 모서리 )
    //2. velocity - 스크롤 속도 입니다. (points / sec)
    guard let collectionView = self.collectionView else {
      let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
      return latestOffset
    }
    
    let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
    guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
    
    //CGFloat값 중 가장 큰 값을 의미
    var offsetAdjustment = CGFloat.greatestFiniteMagnitude
    
    //스크롤뷰가 멈출 중앙지점을 얻을 수 있음
    let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
    
    //itemHorizontalCenter - 각 아이템(셀)들의 x축 중앙 값
    //offsetAdjustment : 스크롤뷰가 멈출것으로 예상되는 포인트에서 가장 가까운 아이템(셀)의 중앙 값을 얻어온 후, 그 값이 스크롤뷰가 멈출 것으로 예상되는 포인트와 얼마나 차이나이는지 계산해서 멈출 지점을 보정해주는데 사용하기 위함
    //반복문을 통해 가장 작은 offsetAdjustment를 갖게 되고 이 값을 스크롤이 멈출 것으로 예상 되는 지점인 proposedContentOffser.x
    for layoutAttributes in rectAttributes {
      let itemHorizontalCenter = layoutAttributes.center.x
      if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
        offsetAdjustment = itemHorizontalCenter - horizontalCenter
      }
    }
    
    //proposedContentOffset을 조절하여 멈추기 원하는 점을 조절가능하다.
    return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
  }
}

