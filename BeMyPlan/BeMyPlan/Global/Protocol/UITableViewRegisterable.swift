//
//  UITableViewRegisterable.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import Foundation

protocol UITableViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UITableView)
}

extension UITableViewRegisterable where Self: UITableViewCell {
    static func register(target: UITableView) {
        if self.isFromNib {
          target.register(UINib(nibName: Self.className, bundle: nil), forCellReuseIdentifier: Self.className)
        } else {
            target.register(Self.self, forCellReuseIdentifier: Self.className)
        }
    }
}
//필요한 셀에 TVC.register(target:TV이름) 형태로 등록 해주기!!!! (원래는 TVC, TV위치가 반대)
//isFromNib는 true일 경우에는 Xib로 TVC 만든거고, false일 경우에는 코드로 TVC 만든거!
