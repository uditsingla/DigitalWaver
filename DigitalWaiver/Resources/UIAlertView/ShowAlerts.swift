//
//  ShowAlerts.swift
//  GOALS
//
//  Created by CSPC162 on 20/10/16.
//  Copyright © 2016 CSPC162. All rights reserved.
//

import UIKit

class ShowAlerts: NSObject {

    
    class func getAlertViewConroller(globleAlert:UIViewController,DialogTitle:NSString,strDialogMessege:NSString){
        
        
        
//        let alert: UIAlertController = UIAlertController(title: DialogTitle as String, message: strDialogMessege as String, preferredStyle: .alert)
//        
//        let attributedString = NSAttributedString(string: "Title", attributes: [
//            NSFontAttributeName : UIFont.systemFont(ofSize: 15), //your font here,
//            NSForegroundColorAttributeName : UIColor.red
//            ])
//        
//        
//        alert.setValue(attributedString, forKey: "attributedTitle")
//        
//        let cancelAction = UIAlertAction(title: "OK",
//                                         style: .default) { (action: UIAlertAction!) -> Void in
//        }
//        
//        alert.addAction(cancelAction)
//        
//         alert.view.tintColor = UIColor.green
//      
//        globleAlert.present(alert, animated: true, completion:nil)
//        
//       
//        
//        
//    }
        
        let alert: UIAlertController = UIAlertController(title: DialogTitle as String, message: strDialogMessege as String, preferredStyle: .alert)
        
        
        let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            
        }
        alert.addAction(nextAction)
              
        globleAlert.present(alert, animated: true, completion:nil)
        
        //alert.view.tintColor = UIColor (colorLiteralRed: 2.0/255.0, green: 151.0/255.0, blue: 213.0/255.0, alpha: 1)
        
    }
    
}
