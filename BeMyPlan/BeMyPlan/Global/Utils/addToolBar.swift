//
//  addToolBar.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import Foundation
import UIKit

extension UIViewController{
  
  public func addToolbar(textfields : [UITextField]){
    let toolBarKeyboard = UIToolbar()
    toolBarKeyboard.sizeToFit()
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let btnDoneBar = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(self.dismissKeyBoard))
    toolBarKeyboard.items = [flexSpace,btnDoneBar]
    for (_,item) in textfields.enumerated(){
      item.inputAccessoryView = toolBarKeyboard

    }
  }
  
  public func addToolBar(textView : UITextView){
    let toolBarKeyboard = UIToolbar()
    toolBarKeyboard.sizeToFit()
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let btnDoneBar = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(self.dismissKeyBoard))
    toolBarKeyboard.items = [flexSpace,btnDoneBar]
    toolBarKeyboard.tintColor = .bemyBlue
    textView.inputAccessoryView = toolBarKeyboard
  }
  
  @objc func dismissKeyBoard(){
    self.view.endEditing(true)
  }
  
  public func addTapGesture(){
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
    self.view.addGestureRecognizer(tap)
  }
  
}
