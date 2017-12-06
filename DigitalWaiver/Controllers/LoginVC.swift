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
    fileprivate let groupPresenter = GroupsPresenter()

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
        
        SVProgressHUD.show(withStatus: "Please Wait...")

        DispatchQueue.main.async {
            

            self.groupPresenter.attachView(self as GroupView)
            self.groupPresenter.getNewData(email: self.txtLogin.text!, password: self.txtPassword.text!)

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

extension LoginVC: GroupView {
    func startLoading() {
        SVProgressHUD.show(withStatus: "Loading.....")

    }
    
    func finishLoading() {
        SVProgressHUD.dismiss()

    }
    
    func finishLoadingWithSuccess() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchWaiverVC") as! SearchWaiverVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func showError(withStatus: String) {
        SVProgressHUD.showInfo(withStatus: withStatus)
    }
    
    func dismissWithDelay(withDelay: Double) {
        SVProgressHUD.dismiss(withDelay: withDelay)
    }
}
