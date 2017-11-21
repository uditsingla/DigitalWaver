//
//  UITextfield+Customization.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//


import Foundation
import UIKit

extension UITextField {
    
     func addShadowToTextfield() {
        self.autocapitalizationType = UITextAutocapitalizationType.none
        self.autocorrectionType = UITextAutocorrectionType.no
        self.font = UIFont(name: "Cormorant-Regular", size: CGFloat(Constants.appFontSize.regularFont))
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        self.leftView = leftView
        self.leftViewMode = .always

    }
    
    func setRightImage(){
        
        self.rightViewMode = UITextFieldViewMode.always
        let star = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        star.font = UIFont(name: "Cormorant-Bold", size: CGFloat(Constants.appFontSize.regularFont))
        star.text = "*"
        star.textColor = .red
        self.rightView = star
    }
}
