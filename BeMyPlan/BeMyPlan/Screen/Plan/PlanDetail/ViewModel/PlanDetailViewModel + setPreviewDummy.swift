//
//  PlanDetailVC + setPreviewDummy.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/20.
//

import UIKit

extension PlanDetailViewModel {
  func setPreviewDummy(completion: @escaping () -> Void){
    makeHeaderDummyData()
    setDayState()
    setMapList()
    setSummaryList()
    setInfoList()
    completion()

    
  }
  
  private func makeHeaderDummyData(){
    headerData = DetailHeaderData.init(title: "친구와 함께 퇴사 기념 힐링여행",
                                       writer: "베이비타이거")
    
    self.makeTopBlockHeight(content: "친구와 함께 퇴사 기념 힐링여행")

    
  }
  
  private func setDayState(){
   totalDay = 3
  }
  
  private func setMapList(){
    locationList.removeAll()
    locationList.append(contentsOf: [
      [
        PlanDetailMapData.init(title: "우무",
                               latitude:33.5098291165892,
                               longtitude: 126.523386649277),
        PlanDetailMapData.init(title: "당신의 공천포 게스트하우스",
                               latitude:33.2646258193542,
                               longtitude: 126.640907286979),
        PlanDetailMapData.init(title: "공천포식당",
                               latitude:33.266389016263,
                               longtitude: 126.64258544722),
        PlanDetailMapData.init(title: "서귀포 매일올레시장",
                               latitude:33.2501489768202,
                               longtitude: 126.563230508718)
      ],
      [
        PlanDetailMapData.init(title: "카페서연의집",
                               latitude:33.2694324178633,
                               longtitude: 126.655567630404),
        PlanDetailMapData.init(title: "솔동산고기국수",
                               latitude:33.2429452564123,
                               longtitude: 126.565223153339),
        PlanDetailMapData.init(title: "천지연폭포",
                               latitude:33.2664146375486,
                               longtitude: 126.554766074558)
      
      ],
      [
        PlanDetailMapData.init(title: "올레삼다정",
                               latitude:33.2530980764684,
                               longtitude: 126.569840612818),
        PlanDetailMapData.init(title: "바이나흐튼크리스마스박물관",
                               latitude:33.2913117398116,
                               longtitude: 126.327798877807),
        PlanDetailMapData.init(title: "스타벅스 제주 용담 DT점",
                               latitude:33.5123994033523,
                               longtitude: 126.484509957101)
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
      [
      PlanDetail.SpotData.init(locationTitle: "우무",
                               address: "제주특별자치도 제주시 관덕로8길 40-1",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150272515-7488ecc4-2bc0-49f7-aed3-caff5b2f8c27.png"],
                               textContent: """
제주 우뭇가사리로 만든 수제 푸딩인데 공항 근처에 있어서 숙소 가기 전에 들렀어요! 전에 왔을 때는 웨이팅이 조금 있었는데 오후 2시쯤에 가니까 사람이 없어서 바로 구매할 수 있었습니다 ㅎㅎ 맛은 커스터드, 초코, 우도땅콩 푸딩 세 개를 구매했는데 다 너무 맛있었어요. 커스터드 맛은 산뜻하고 적당히 단 맛이라면, 초코랑 우도 땅콩 맛은 재료가 많이 들어갔는지 진한 맛이었습니다.

인위적인 보존제를 넣지 않아 구입 후 30분 이내로 바로 먹으라고 하는데, 겨울 기준 하루 정도는 실온에 두었다 먹어도 괜찮았어요! 가게 내부 취식이 안되니 정 걱정되시는 분들은 위 주의사항을 유념해서 여행 동선을 조정하시면 좋을 것 같아요.

그리고 제가 갔을 때만 그랬을 수도 있지만, 지난 여름에 오후 5시쯤에 방문하니 물류가 와서 트럭이 가게 앞을 막더라구요. 가게 앞 포토존에서 사진 찍고 싶으신 분들은 이 점도 유의하시면 좋을 것 같습니다!
""",
                               nextLocationData: PlanDetail.Summary.init(transportCase: .car,
                                                                        locationName: "우무",
                                                                        time: "52분")),
      PlanDetail.SpotData.init(locationTitle: "당신의 공천포 게스트하우스",
                               address: "제주특별자치도 서귀포시 남원읍 공천포로 63",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150272598-4c9d4e6f-77b3-4133-ae5d-844579cadd47.png","https://user-images.githubusercontent.com/63637706/150272605-c5ffcc52-388a-4f9d-9f63-9b97f298fe20.png","https://user-images.githubusercontent.com/63637706/150272609-edc075b3-4866-4087-872c-95c6c0bdb8ce.png"],
                               textContent: """
방에서 바다가 보이는 게스트하우스라고 해서 방문했습니다. 이전에 게스트하우스를 방문해본 적이 없어서 막연한 거부감이 들었었는데요. 하지만 여행 기간 내내 이 숙소에 머무르면서 정말 만족했습니다! 아침에 일출을 방 안에서 볼 수 있다는 것만으로도 이 숙소는 충분히 가치가 있다고 생각해요ㅎㅎ 아침 조식도 9시쯤 제공되는데 브런치 양식으로 제공되어서 커피와 함께 여유로운 아침을 시작할 수 있습니다. 단점이 있다면 숙소-도로-바다 순으로 되어 있어서 사람들이 창밖으로 지나다닌다는 점인데, 잘 때나 사생활이 필요할 때 커튼을 닫아두고 생활하면 될 것 같아요.

고양이가 2마리 있습니다! 한 마리는 정말 시크하지만, 다른 고양이는 놀아주면 아주 좋아하고 회 같은 걸 먹으면 옆에 와서 구경할 정도로(실제로 먹으려 하진 않고 구경만 열심히 해요ㅎㅎ )사교적이예요! 그리고 숙소가 올레길 5코스 쪽에 위치하고 있기 때문에 주변을 산책하기도 좋아요!

서귀포시 내에서는 대중교통으로 편하게 움직일 수 있지만, 제주시-서귀포시 간에는 조금 어려워서 택시나 차를 이용하는 것을 추천드려요! (한 번에 가는 버스가 있긴 하지만, 하루에 몇 번 안 지나다녀서 그걸 타는 건 어려울 것 같아요)
""",
                               nextLocationData:         PlanDetail.Summary.init(transportCase: .walk,
                                                                                 locationName: "당신의 공천포 게스트하우스",
                                                                                 time: "3분")),
      PlanDetail.SpotData.init(locationTitle: "공천포식당",
                               address: "제주특별자치도 서귀포시 남원읍 공천포로 89",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150272650-1e98658c-1802-4e9f-9d7f-fd9faec1f8af.png","https://user-images.githubusercontent.com/63637706/150272653-e8026d05-85a4-40d0-8af5-037f93b0cba0.png"],
                               textContent: """
숙소 바로 옆에 식당이 있어서 방문해봤는데 생각 외로 맛있어서 만족스러웠습니다! 전복 물회와 전복죽을 먹었는데 물회는 100% 된장 베이스라 다른 고추장 베이스 물회랑은 또 다른 묘미더라구요. 물회와 죽 모두 전복이 아낌없이 들어가서 너무 좋았습니다.

오이가 정말! 많이 들어가서 오이를 싫어하시는 분들은 미리 주문할 때 말씀을 드려야 해요.
""",
                               nextLocationData: PlanDetail.Summary.init(transportCase: .bus,
                                                                         locationName: "공천포식당",
                                                                         time: "16분")),
      PlanDetail.SpotData.init(locationTitle: "서귀포 매일올레시장",
                               address: "제주특별자치도 서귀포시 중앙로62번길 18",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150273440-53790f9c-b1ac-46e4-8a1a-ff97675bbdb3.png"],
                               textContent: """
야식으로 먹을 회포장과 본가로 귤 배달을 시키기 위해 방문했습니다. 유명한 시장이라 그런지 사람들이 많았어요. 저렴하게 회포장하고 가볍게 지인들에게 줄 기성 기념품 구입할 때 방문하는 걸 추천드려요!

회포장과 기성 기념품은 거의 다 가격이 똑같기 때문에 사람 적은 곳으로 가서 빠르게 사는 것을 더 추천합니다😊
""",
                               nextLocationData:         PlanDetail.Summary.init(transportCase: .car,
                                                                                 locationName: "서귀포 매일올레시장",
                                                                                 time: ""))
      ],
      
      //2일차
      
      [
      PlanDetail.SpotData.init(locationTitle: "카페서연의집",
                               address: "제주특별자치도 서귀포시 남원읍 위미해안로 86",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150273123-d68c285e-ff56-46c7-ad23-04c16e4e3fe0.png","https://user-images.githubusercontent.com/63637706/150273126-8de46dc7-d4ca-4bdd-8704-a68590b8858b.png","https://user-images.githubusercontent.com/63637706/150273129-565c4029-1db7-4793-9491-7988e661728f.png","https://user-images.githubusercontent.com/63637706/150273132-64c5ee30-3146-4274-bf07-e31724428494.png"],
                               textContent: """
영화 ‘건축학개론’에 등장한 촬영 장소인데, 영화를 몰라도 한 번 가보시는 것을 추천해요! 넓은 창문과 그 너머로 바다가 가득 담긴 모습을 보며 힐링하니까 시간 가는 줄 모르겠더라구요. 그리고 본 건물 외에도 승민의 작업실도 있는데 승민의 작업실은 밖이 작게 보이지만 작업실 내의 분위기가 포근하고 안락해서 탁 트인 바다뷰와는 또 다른 매력이 있었어요!

숙소에서 올레길 5코스 따라 도보 30분 정도 걸으면 바로 나와서 날이 좋거나 걷는 것 좋아하는 분들은 걸어가도 좋을 것 같아요! 그리고 2층 테라스 자리도 좋지만, 날이 춥거나 더운 경우 1층 카운터 바로 앞자리의 뷰가 제일 좋으니까 들어가자마자 자리가 있으면 무조건 자리부터 잡고 주문하는 것을 추천 드립니다.
""",
                               nextLocationData:         PlanDetail.Summary.init(transportCase: .bus,
                                                                                 locationName: "카페서연의집",
                                                                                 time: "38분")),
      
      PlanDetail.SpotData.init(locationTitle: "솔동산고기국수",
                               address: "제주특별자치도 서귀포시 부두로 23",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150273682-ada6eb4f-7ae2-4744-b4d1-cfc848c7a7ad.png"],
                               textContent: """
이중섭거리 근처에 있어서 뚜벅이 여행자들도 쉽게 찾아갈 수 있어요. 고기국수와 해물국수 한 개씩 주문했는데 고기국수는 국물이 진하고 고기가 부드러웠습니다. 그리고 해물국수는 해물이 많이 들어서 해물 먼저 먹다가 배가 불러서 국수를 조금 남길 정도였어요 ㅎㅎ 둘이 방문한다면 하나씩 시켜서 같이 먹는 것 추천드려요!

맞은편에 주차장이 있어서 자차를 이용하시는 분들도 편하게 이용할 수 있을 듯 합니다.
""",
                               nextLocationData:         PlanDetail.Summary.init(transportCase: .walk,
                                                                                 locationName: "솔동산고기국수",
                                                                                 time: "10분")),
      PlanDetail.SpotData.init(locationTitle: "천지연폭포",
                               address: "제주특별자치도 서귀포시 서홍동 2565",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150273644-aabf1a14-7f84-4dd2-a76a-40a849d30a5e.png"],
                               textContent: """
솔동산고기국수 바로 근처에 천지연폭포가 있어서 산책할 겸 가볍게 걸어서 방문했습니다. 입장료는 만 25세 이상 성인은 2천원, 미만은 1천원인데 데스크나 무인 발권기를 이용해 표를 발권 받을 수 있어요! 관람료도 저렴하고 산책하기 좋은 길이라 밥 먹고 가볍게 방문하기 좋았어요!

검표소 이후로는 음료 반입 금지 및 금연 구역이니 산책하실 때 참고하시면 좋을 것 같습니다!
""",
                               nextLocationData:         PlanDetail.Summary.init(transportCase: .walk,
                                                                                 locationName: "천지연폭포",
                                                                                 time: "10분"))
      ],
      
      // 3일차
      
      [
      PlanDetail.SpotData.init(locationTitle: "올레삼다정",
                               address: "제주특별자치도 서귀포시 태평로537번길 48",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150273578-d1d26627-9191-4680-8184-416d270e563d.png"],
                               textContent: """
친구가 통갈치구이를 꼭 먹고 싶다고 해서 방문했습니다. 생선구이를 별로 좋아하지 않는 저도 너무 맛있게 잘 먹었어요! 그리고 갈치가 뼈가 많아서 먹기 힘들 수 있는데, 사장님이 큼직하게 손질해주셔서 먹는데 전혀 어렵지 않았습니다. 다음에 또 방문하고 싶을 정도로 밥 도둑이예요 ㅎㅎ

사장님께서 갈치를 손질해서 먹는 법을 알려주시는데 그 방법대로 꼭 드셔보세요! 저는 원래 생선구이를 별로 좋아하지 않았는데 사장님의 가이드 대로 처음 한입 먹었을 때 너무 맛있어서 생선구이를 좋아하게 되었습니다 ㅎㅎ 그리고 단품으로 시키기보다 세트로 시켜서 갈치조림, 보말 죽과 보말 미역국도 드시는 걸 추천드려요! 갈치 조림도 사장님의 가이드대로 살을 발라서 먹어보면 소스와 함께 환상적인 궁합으로 먹을 수 있을거예요 ㅎㅎ
""",
                               nextLocationData:         PlanDetail.Summary.init(transportCase: .car,
                                                                                 locationName: "올레삼다정",
                                                                                 time: "30분")),
      
      PlanDetail.SpotData.init(locationTitle: "바이나흐튼크리스마스박물관",
                               address: "제주특별자치도 서귀포시 안덕면 평화로 654",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150272860-3c6cf46a-157b-4342-81ea-4871d5f4b8bd.png"],
                               textContent: """
크리스마스 시즌이 되려면 조금 남았었지만 크리스마스 어드벤트 캘린더를 구매하고 싶어서 겸사겸사 방문했습니다! 박물관이지만 무료로 관람할 수 있고 기부금으로 운영된다고 해요. 12월에는 크리스마스 마켓도 운영된다고 하는데, 제가 방문한 11월에는 아직 마켓 준비중이여서 아쉬웠어요. 호두까기 인형을 비롯해서 다양한 빈티지 제품과 크리스마스 관련 제품들을 구경하고 구매할 수 있어서 흥미로웠습니다. 메인 건물 외에도 옆에 카페와 별관이 있으니 차근차근 둘러보다보면 시간 가는 줄 모를 것 같아요!
""",
                               nextLocationData:         PlanDetail.Summary.init(transportCase: .bus,
                                                                                 locationName: "바이나흐튼 크라스마스박물관",
                                                                                 time: "35분")),
      PlanDetail.SpotData.init(locationTitle: "스타벅스 제주 용담 DT점",
                               address: "제주특별자치도 제주시 서해안로 380 1층",
                               imagerUrls: ["https://user-images.githubusercontent.com/63637706/150272808-2974110c-3aca-4a00-a382-eca29b72d1b3.png ("],
                               textContent: """
비행기 시간까지 얼마 남지 않아서 공항 근처 바다가 보이는 스타벅스를 방문했습니다! 해지는 시간에 방문해서 그런지 창 밖으로 일몰을 감상할 수 있었습니다. 날이 추워 산책하진 않았지만 날이 따뜻할 때 카페 앞 바다에서 산책하는 것도 좋을 것 같아요!

제주에서만 판매하는 음료와 굿즈를 겟하는 것을 추천드립니다! 시즌마다 조금씩 다르게 나와서 매번 다른 제주 음료를 맛보는 재미가 있더라구요 ㅎㅎ
""",
                               nextLocationData:         PlanDetail.Summary.init(transportCase: .bus,
                                                                                 locationName: "스타벅스 제주용담DT점",
                                                                                 time: "38분"))
      ]
    ])
  }
}
