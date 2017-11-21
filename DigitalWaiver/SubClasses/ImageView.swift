//
//  ImageView.swift
//  Flippersplash
//
//  Created by Apple on 17/10/17.
//  Copyright © 2017 Sourcefuse. All rights reserved.
//

import Foundation
import UIKit

class ImageView : UIImageView {
    let a: UIRectEdge = UIRectEdge()
    
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
