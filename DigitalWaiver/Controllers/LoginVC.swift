//
//  LoginVC.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 06/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginVC: UIViewController {

    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionLogin(_ sender: RoundedButton) {
        
        let strMessage = Validations.validateLoginCredentials(email: txtLogin.text!, password: txtPassword.text!)
        if (strMessage != "")
        {

            SVProgressHUD.showError(withStatus: strMessage)
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)

            return
        }
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["email"] = txtLogin.text!
        dictData["password"] = txtPassword.text!
//        dictData["email"] = "test@gmail.com"
//        dictData["password"] = "123456"
        
        
        SVProgressHUD.show(withStatus: "Loading.....")
        
        ModelManager.sharedInstance.authManager.userLogin(userInfo: dictData) { (userObj, isSuccess, strMessage) in
            
            SVProgressHUD.dismiss()
            
            if(isSuccess)
            {
                print("Login Done")
                
                ModelManager.sharedInstance.waverManager.getBuisnessName(participantInfo: nil, handler: { (isSuccess, strMessage) in
                    
                    if (isSuccess)
                    {
                        ModelManager.sharedInstance.authManager.setUserDefaultValues()
                        
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "SearchWaiverVC") as! SearchWaiverVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                        
                        SVProgressHUD.showInfo(withStatus: strMessage)
                        SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
                    }
                })
                //self.performSegue(withIdentifier: "goto_homeview", sender: nil)
                
            }
            else
            {
                SVProgressHUD.showError(withStatus: strMessage)
                SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
