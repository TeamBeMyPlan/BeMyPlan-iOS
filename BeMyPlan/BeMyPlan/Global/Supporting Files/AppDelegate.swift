//
//  AppDelegate.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/04.
//


import UIKit
import FirebaseCore
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  override init() {
    super.init()
    UIFont.overrideInitialize()
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    setupFirebaseSDK()
    KakaoSDK.initSDK(appKey: "8813c8c6fdcec872713a666700d19b80")
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.portrait
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    if UserDefaults.standard.bool(forKey: "isFirstOpen") == false {
      AppLog.log(at: FirebaseAnalyticsProvider.self, .appFirstOpen)
      UserDefaults.standard.set(true, forKey: "isFirstOpen")
    }
  }
}

extension AppDelegate{
  func setupFirebaseSDK() {
    FirebaseConfiguration.shared.setLoggerLevel(.min)
    AppLog.configure()
  }
}
