//
//  UILabel+Customization.swift
//  
//
//  Created by Apple on 22/05/17.
//  Copyright © 2017 Abhishek Singla. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    class func fitLabeltoFixWidth(label :UILabel)  {
        
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        
    }
    
    func setLabelBoarder(){
        
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
    }
    
}

