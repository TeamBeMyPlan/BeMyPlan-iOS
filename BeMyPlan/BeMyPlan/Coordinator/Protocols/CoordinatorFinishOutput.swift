//
//  CoordinatorFinishOutput.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/31.
//

protocol CoordinatorFinishOutput {
  var finishScene: (() -> Void)? { get set }
}
