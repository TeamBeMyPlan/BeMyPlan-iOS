//
//  AnalyticsType.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/03/03.
//

import Foundation

public protocol AnalyticsType {
  associatedtype Event: EventType
  func register(provider: ProviderType)
  func log(_ event: Event)
}

public protocol ProviderType {
  func log(_ eventName: String, parameters: [String: Any]?)
}

public protocol EventType {
  func name(for provider: ProviderType) -> String?
  func parameters(for provider: ProviderType) -> [String: Any]?
}

open class AnalyticsManager<Event: EventType>: AnalyticsType {
  private(set) open var providers: [ProviderType] = []

  public init() {}

  open func register(provider: ProviderType) {
    self.providers.append(provider)
  }

  open func log(_ event: Event) {
    for provider in self.providers {
      guard let eventName = event.name(for: provider) else { continue }
      let parameters = event.parameters(for: provider)
      provider.log(eventName, parameters: parameters)
    }
  }
}
