//
//  TextField.swift
//  Flippersplash
//
//  Created by Deepak on 14/09/17.
//  Copyright © 2017 Sourcefuse. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {
    
    @IBInspectable var mandatory = true
    
    // Drawing code
    override func draw(_ rect: CGRect) {
        
        self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "", attributes:[NSAttributedStringKey.foregroundColor: Constants.Colors.placeHolderColor])
    }
    
}




