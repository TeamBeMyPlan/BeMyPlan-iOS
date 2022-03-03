//
//  AppLog.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/03.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics

enum LogProviderType: String {
  case firebaseAnalyticsProvider = "FirebaseAnalyticsProvider"
}

class AppLog {
  
  private static var crashlyticsService: CrashlyticsServiceProtocol.Type = Crashlytics.self
  private static var configureService: FirebaseConfigureServiceProtocol.Type = FirebaseApp.self
  private static var analyticsService: FirebaseAnalyticsServiceProtocol.Type = Analytics.self
  private static let analytics = AnalyticsManager<LogEventType>()
  
  static func configure() {
    self.configureService.configure()
    self.analytics.register(provider: FirebaseAnalyticsProvider())
  }
  
  static func setFirebaseUserProperty() {
    let userIdx = String(UserDefaults.standard.integer(forKey: "userIdx"))
    analyticsService.setUserProperty(userIdx, forName: "userIdx")
  }
  
  static func log(at providerType: ProviderType.Type, _ event: LogEventType) {
      self.analytics.log(at: providerType, event)
  }
}

extension AnalyticsManager {
  func log(at providerType: ProviderType.Type, _ event: Event) {
    for provider in self.providers {
      guard type(of: provider.self) == providerType.self else { continue }
      guard let eventName = event.name(for: provider) else { continue }
      let parameters = event.parameters(for: provider)
      provider.log(eventName, parameters: parameters)
    }
  }
}
