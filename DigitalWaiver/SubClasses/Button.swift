//
//  Button.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 31/08/17.
//  Copyright © 2017 Sourcefuse. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    override func draw(_ rect: CGRect) {
        //code below is drawing a shadow for button
        self.layer.shadowColor = UIColor(red: 155/255, green: 174/255, blue: 191/255, alpha: 1).cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.35
        self.layer.backgroundColor = UIColor.white.cgColor
        super.draw(rect)
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = (isHighlighted && cornerRadius == 0) ? UIColor(red: 243/255, green: 62/255, blue: 105/255, alpha: 1) : UIColor.white
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
}

@IBDesignable
class RoundedButton:UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


