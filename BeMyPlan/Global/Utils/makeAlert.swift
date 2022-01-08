//
//  makeAlert.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/05.
//

import UIKit

/**

  - Description:
 
            요청하는(OK,취소)버튼만 있는 UIAlertController를 간편하게 만들기 위한 extension입니다.

  - parameters:
    - title: 알림창에 뜨는 타이틀 부분입니다.
    - message: 타이틀 밑에 뜨는 메세지 부분입니다.
    - okAction: 확인버튼을 눌렀을 때 동작하는 부분입니다.
    - cancelAction: 취소버튼을 눌렀을 때 동작하는 부분입니다.
    - completion: 해당 UIAlertController가 띄워졌을 때, 동작하는 부분입니다.
 
*/

extension UIViewController
{
    func makeRequestAlert(title : String,
                   message : String,
                   okAction : ((UIAlertAction) -> Void)?,
                   cancelAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil)
    {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true, completion: completion)
    }
    
/**

    - Description:
   
              간단하게 OK버튼 하나만 있는 UIAlertController를 간편하게 만들기 위한 extension입니다.

    - parameters:
 
        위와 동일함.
  
 */
  
    func makeAlert(title : String,
                   message : String,
                   okAction : ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil)
    {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: completion)
    }
}
