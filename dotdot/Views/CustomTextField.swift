//
//  CustomTextField.swift
//  dotdot
//
//  Created by Arsalan majlesi on 7/4/21.
//

import UIKit

@IBDesignable
class CustomTextField :UITextField{
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView(){
        let attribute = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        self.attributedPlaceholder = attribute
    }
}
