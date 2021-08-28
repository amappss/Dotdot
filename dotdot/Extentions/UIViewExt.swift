//
//  UIViewExt.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import UIKit

extension UIView{
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
   @objc func keyboardWillChangeFrame(_ notification:NSNotification){
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingFrame = notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let endFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    
    UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: KeyframeAnimationOptions(rawValue: curve), animations: {
        self.frame.origin.y += endFrame.origin.y - startingFrame.origin.y
    }, completion: nil)
    
    }
}
