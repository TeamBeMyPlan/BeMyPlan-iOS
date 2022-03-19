//
//  ViewModelType.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/29.
//

import Foundation
import RxSwift

protocol ViewModelType{
  associatedtype Input
  associatedtype Output
  
  func transform(from input: Input, disposeBag: DisposeBag) -> Output
}
