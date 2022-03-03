//
//  FirebaseAnalyticsProvider.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/03.
//

import FirebaseCore
import FirebaseAnalytics

open class FirebaseAnalyticsProvider: RuntimeProviderType {
  public let className: String = "FIRAnalytics"
  public let selectorName: String = "logEventWithName:parameters:"

  public init() {}
}
