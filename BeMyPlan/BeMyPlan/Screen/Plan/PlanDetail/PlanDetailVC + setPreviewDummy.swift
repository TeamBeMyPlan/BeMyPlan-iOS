//
//  PlanDetailVC + setPreviewDummy.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/20.
//

import UIKit

extension PlanDetailVC {
  func setPreviewDummy(){
    makeHeaderDummyData()
    setDayState()
    setMapList()
    setSummaryList()
    
  }
  
  private func makeHeaderDummyData(){
    headerData = DetailHeaderData.init(title: "친구와 함께 퇴사 기념 힐링여행",
                                       writer: "베이비타이거")
    
  }
  
  private func setDayState(){
   totalDay = 3
  }
  
  private func setMapList(){
    locationList.removeAll()
    locationList.append(contentsOf: [
      [
        PlanDetailMapData.init(title: "우무",
                               latitude:126.523386649277,
                               longtitude: 33.5098291165892),
        PlanDetailMapData.init(title: "당신의 공천포 게스트하우스",
                               latitude:126.640907286979,
                               longtitude: 33.2646258193542),
        PlanDetailMapData.init(title: "공천포식당",
                               latitude:126.64258544722,
                               longtitude: 33.266389016263),
        PlanDetailMapData.init(title: "서귀포 매일올레시장",
                               latitude:126.563230508718,
                               longtitude: 33.2501489768202)
      ],
      [
        PlanDetailMapData.init(title: "카페서연의집",
                               latitude:126.655567630404,
                               longtitude: 33.2694324178633),
        PlanDetailMapData.init(title: "솔동산고기국수",
                               latitude:126.565223153339,
                               longtitude: 33.2429452564123),
        PlanDetailMapData.init(title: "천지연폭포",
                               latitude:126.554766074558,
                               longtitude: 33.2664146375486)
      
      ],
      [
        PlanDetailMapData.init(title: "올레삼다정",
                               latitude:126.569840612818,
                               longtitude: 33.2530980764684),
        PlanDetailMapData.init(title: "바이나흐튼크리스마스박물관",
                               latitude:126.327798877807,
                               longtitude: 33.2913117398116),
        PlanDetailMapData.init(title: "스타벅스 제주 용담 DT점",
                               latitude:126.484509957101,
                               longtitude: 33.5123994033523)
      ]

    ])
  }
  
  private func setSummaryList(){
    summaryList.removeAll()
    summaryList.append(contentsOf: [
      [
        PlanDetail.Summary.init(transportCase: .car,
                                locationName: "우무",
                                time: "52분"),
        PlanDetail.Summary.init(transportCase: .walk,
                                locationName: "당신의 공천포 게스트하우스",
                                time: "3분"),
        PlanDetail.Summary.init(transportCase: .bus,
                                locationName: "공천포식당",
                                time: "16분"),
        PlanDetail.Summary.init(transportCase: .car,
                                locationName: "서귀포 매일올레시장",
                                time: "")
      ],
      [
        PlanDetail.Summary.init(transportCase: .bus,
                                locationName: "카페서연의집",
                                time: "38분"),
        PlanDetail.Summary.init(transportCase: .walk,
                                locationName: "솔동산고기국수",
                                time: "10분"),
        PlanDetail.Summary.init(transportCase: .walk,
                                locationName: "천지연폭포",
                                time: "10분")
        
      ],
      [
        PlanDetail.Summary.init(transportCase: .car,
                                locationName: "올레삼다정",
                                time: "30분"),
        PlanDetail.Summary.init(transportCase: .bus,
                                locationName: "바이나흐튼 크라스마스박물관",
                                time: "35분"),
        PlanDetail.Summary.init(transportCase: .bus,
                                locationName: "스타벅스 제주용담DT점",
                                time: "38분")
      ]
    ])
  }
  
  private func setInfoList(){
    infoList.removeAll()
    infoList.append(contentsOf: [
      PlanDetail.SpotData.init(locationTitle: "우무",
                               address: "제주특별자치도 제주시 관덕로8길 40-1",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150272515-7488ecc4-2bc0-49f7-aed3-caff5b2f8c27.png"],
                               textContent: """
제주 우뭇가사리로 만든 수제 푸딩인데 공항 근처에 있어서 숙소 가기 전에 들렀어요! 전에 왔을 때는 웨이팅이 조금 있었는데 오후 2시쯤에 가니까 사람이 없어서 바로 구매할 수 있었습니다 ㅎㅎ 맛은 커스터드, 초코, 우도땅콩 푸딩 세 개를 구매했는데 다 너무 맛있었어요. 커스터드 맛은 산뜻하고 적당히 단 맛이라면, 초코랑 우도 땅콩 맛은 재료가 많이 들어갔는지 진한 맛이었습니다.

인위적인 보존제를 넣지 않아 구입 후 30분 이내로 바로 먹으라고 하는데, 겨울 기준 하루 정도는 실온에 두었다 먹어도 괜찮았어요! 가게 내부 취식이 안되니 정 걱정되시는 분들은 위 주의사항을 유념해서 여행 동선을 조정하시면 좋을 것 같아요.

그리고 제가 갔을 때만 그랬을 수도 있지만, 지난 여름에 오후 5시쯤에 방문하니 물류가 와서 트럭이 가게 앞을 막더라구요. 가게 앞 포토존에서 사진 찍고 싶으신 분들은 이 점도 유의하시면 좋을 것 같습니다!
""",
                               nextLocationData: <#T##PlanDetail.Summary?#>)
      
    
    
    
    ])
  })
}
