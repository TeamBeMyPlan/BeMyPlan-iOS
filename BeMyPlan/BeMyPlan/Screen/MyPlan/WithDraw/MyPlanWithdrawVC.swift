//
//  MyPlanWithdrawVC.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/12.
//

import UIKit

class MyPlanWithdrawVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  
  // MARK: - UI Component Part
  
  @IBOutlet var contentTextView: UITextView!{
    didSet{
      contentTextView.delegate = self
    }
  }
  @IBOutlet var nextButton: BarFullButton!
  
  @IBOutlet var nextButtonBottomConstraint: NSLayoutConstraint!
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addTapGesture()
    setTextViewUI()
    setButtonActions()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    registerForKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    unregisterForKeyboardNotifications()
  }
  
  // MARK: - IBAction Part
  
  
  // MARK: - Custom Method Part
  
  private func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func unregisterForKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func setButtonActions(){
    nextButton.press {
      self.makeAlert(alertCase: .requestAlert, title: "탈퇴하기", content: "정말 탈퇴하시겠습니까?") {
        //실제로는 이방법이 아니라 dismiss 되었을때 completion에 새로운 escaping closure를 선언해서 파라미터로 받아와서 해야한다....!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) {
          self.makeAlert(alertCase: .simpleAlert, title: "탈퇴하기", content: "탈퇴 완료되었습니다.") {
            print("탈퇴하기 커스텀 Alert 완료")
          }
        }
      }
    }
  }
  
  private func setButtonUI(){
    nextButton.setButtonState(isSelected: false, title: I18N.Components.next)
  }
  
  private func setTextViewUI(){
    contentTextView.font = .systemFont(ofSize: 14)
    contentTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    contentTextView.layer.cornerRadius = 5
    contentTextView.layer.borderColor = UIColor.grey04.cgColor
    contentTextView.layer.borderWidth = 1
    addToolBar(textView: contentTextView)
  }
  
  // MARK: - @objc Function Part
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
      nextButtonBottomConstraint.constant = keyboardHeight
    }
    
    UIView.animate(withDuration: duration, delay: 0){
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
    nextButtonBottomConstraint.constant = 253
    UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve)) {
      self.view.layoutIfNeeded()
    }
  }
  
}
// MARK: - Extension Part
extension MyPlanWithdrawVC : UITextViewDelegate{
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == I18N.MyPlan.Withdraw.placeHolder{
      contentTextView.text = ""
      contentTextView.textColor = .grey01
    }
    contentTextView.layer.borderColor = UIColor.bemyBlue.cgColor
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty{
      textView.text = I18N.MyPlan.Withdraw.placeHolder
      textView.textColor = .grey04
    }
    contentTextView.layer.borderColor = UIColor.grey04.cgColor
  }
  
  func textViewDidChange(_ textView: UITextView) {
    nextButton.setButtonState(isSelected: !contentTextView.text.isEmpty, title: I18N.Components.next)
  }
}
