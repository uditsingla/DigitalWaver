//
//  SignUpVC.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 06/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import SVProgressHUD
class SignUpVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSignup(_ sender: RoundedButton)
        {
            var  dictData : [String : Any] =  [String : Any]()

            let strMessage = Validations.validateSignUpCredentials(fullName: txtName.text!, email: txtEmail.text!, address: txtAddress.text!, password: txtPassword.text!, confirmPassword: txtRePass.text!)
            
            if(strMessage != "")
            {
                SVProgressHUD.showError(withStatus: strMessage)
                SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)

                return
            }
            else
            {
                dictData["full_name"] = txtName.text!
                dictData["address"] = txtAddress.text!
                dictData["email"] = txtEmail.text!
                dictData["password"] = txtPassword.text!
            }
            
            SVProgressHUD.show(withStatus: "Loading.....")
            
            ModelManager.sharedInstance.authManager.userSignUp(userInfo: dictData) { (userObj, isSuccess, strMessage) in
                
                SVProgressHUD.dismiss()
                
                if(isSuccess)
                {
                    print("Signup Done")
                    
                    dictData["full_name"] = ""
                    dictData["address"] = ""
                    dictData["email"] = ""
                    dictData["password"] = ""
                    
                    self.txtName.text = ""
                    self.txtAddress.text = ""
                    self.txtEmail.text = ""
                    self.txtPassword.text = ""
                    self.txtRePass.text = ""
                    
                    SVProgressHUD.showInfo(withStatus: "Signup successful, Now add buissness from web portal")
                    SVProgressHUD.dismiss(withDelay: 3)
                    
                }
                else
                {
                    SVProgressHUD.showError(withStatus: strMessage)
                    SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
                }
                
            }
            
        }
    
    
    @IBAction func actionLogin(_ sender: RoundedButton) {
        
        self.navigationController?.popViewController(animated: true)
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
