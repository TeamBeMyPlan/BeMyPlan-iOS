//
//  FirebaseServiceProtocol.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/03.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics

protocol FirebaseConfigureServiceProtocol: AnyObject {
  static func configure()
}

protocol FirebaseAnalyticsServiceProtocol: AnyObject {
  static func logEvent(_ name: String, parameters: [String: Any]?)
  static func setUserProperty(_ value: String?, forName name: String)
  static func setUserID(_ userID: String?)
  static func resetAnalyticsData()
}

protocol CrashlyticsServiceProtocol: AnyObject {
  static func crashlytics() -> Self
}

extension FirebaseApp: FirebaseConfigureServiceProtocol {}
extension Analytics: FirebaseAnalyticsServiceProtocol {}
extension Crashlytics: CrashlyticsServiceProtocol {}
