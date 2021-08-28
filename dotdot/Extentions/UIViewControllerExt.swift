//
//  UIViewControllerExt.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/7/21.
//

import UIKit

extension UIViewController {
    
    func showDetail(_ viewController:UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewController, animated: false, completion: nil)
    }
    
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
