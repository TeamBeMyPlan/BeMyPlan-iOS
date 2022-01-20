//
//  showIndicator.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/21.
//

import UIKit


extension UIViewController{
  
  func showIndicator(){

    
    guard let indicatorVC = UIStoryboard.list(.indicator).instantiateViewController(withIdentifier: IndicatorVC.className) as? IndicatorVC else {return}
    indicatorVC.modalTransitionStyle = .crossDissolve
    indicatorVC.modalPresentationStyle = .overCurrentContext
    self.present(indicatorVC, animated: true, completion: nil)
  }
  
  func closeIndicator(completion : @escaping ()->()){
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
      NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "indicatorComplete"), object: nil)
      completion()
    }
    

 
  }
}
