//
//  WaverVC.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 08/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import SVProgressHUD
import ReachabilitySwift

class WaverVC: UIViewController,UITextFieldDelegate {

    // MARK: - Local vars

    @IBOutlet weak var txtParticipantsNo: UITextField!
    @IBOutlet weak var txtGroupName: UITextField!
    var particiantNo : Int64 = 0
    
    // MARK: - Default Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions

    @IBAction func actionAdd(_ sender: RoundedButton) {
        
        resignAllResponder()

        particiantNo = particiantNo + 1
        txtParticipantsNo.text = "\(particiantNo)"
    }
    
    @IBAction func actionMinus(_ sender: RoundedButton) {
        
        resignAllResponder()

        if(particiantNo > 0)
        {
            particiantNo = particiantNo - 1

            txtParticipantsNo.text = "\(particiantNo)"
        }
    }
    
    @IBAction func actionSubmit(_ sender: RoundedButton) {
        
        let strMessage = Validations.validateAddGroup(name: txtGroupName.text!, participants: txtParticipantsNo.text!)
        if (strMessage != "")
        {
            SVProgressHUD.showError(withStatus: strMessage)
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
            return
        }
        
        resignAllResponder()

        /*
        var  dictData : [String : Any] =  [String : Any]()
        let userDefault = UserDefaults.standard
        dictData["businessname"] = userDefault.string(forKey: "buisnessName")
        dictData["participants_no"] = "\(particiantNo)"
        dictData["group_name"] = txtGroupName.text
        
        if let a = dictData["businessname"] as? String
        {
            if let b = dictData["group_name"] as? String
            {
                dictData["link"] = "http://digital-waiver.appspot.com/viewwaiverform.html?businessname="+a+"&groupname="+b
            }
        }
        */
        
        //debugPrint(dictData)
        
        saveDataInLocalDB()
        
       
    }
    
    
    

    // MARK: - Custom Functions
    
    func saveDataInLocalDB()
    {
        let dictWaiver = (UserDefaults.standard.object(forKey: "dictWaversData") as! [String : Any])
        
        var dictData = [String : String]()
        dictData["businessname"] = UserDefaults.standard.string(forKey: "buisnessName")
        dictData["participants_no"] = "\(particiantNo)"
        dictData["group_name"] = txtGroupName.text
        
        if let a = dictData["businessname"]
        {
            if let b = dictData["group_name"]
            {
                dictData["link"] = "http://digital-waiver.appspot.com/viewwaiverform.html?businessname="+a+"&groupname="+b
            }
        }
        
        let arrMutable : NSArray = dictWaiver["data"] as! NSArray

        let ary_mutable = NSMutableArray()
        ary_mutable.addObjects(from: arrMutable as [AnyObject])
        ary_mutable.add(dictData)
        
        
        let dict : [String : Any] = ["data": ary_mutable]
        
        UserDefaults.standard.set(dict, forKey: "dictWaversData")
        UserDefaults.standard.synchronize()
        
        //APiHit
        let reach = Reachability()
        if let reachable : String = reach?.currentReachabilityString
        {
            if(reachable != "No Connection")
            {
                self.addParticiant(dictData: dict)
            }
            else
            {
                self.txtGroupName.text = ""
                self.txtParticipantsNo.text = ""
            }
        }
        
    }
    
    func addParticiant(dictData : [String : Any])
    {
        SVProgressHUD.show(withStatus: "Loading.....")
        ModelManager.sharedInstance.waverManager.addWaver(userInfo: dictData, handler: { (isSuccess, strMessage) in
            SVProgressHUD.dismiss()
            
            if(isSuccess)
            {
                print(strMessage)
                SVProgressHUD.showSuccess(withStatus: strMessage)
                SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "AddParticipant") as! AddParticipant
                vc.strGroupName = self.txtGroupName.text!
                vc.isWaverSelected = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                SVProgressHUD.showError(withStatus: strMessage)
                SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
            }
        })
    }
    
    
    func resetData()
    {
        particiantNo = 0
        txtGroupName.text = ""
        txtParticipantsNo.text = ""
    }
    func resignAllResponder()  {
        self.view.endEditing(true)
    }

    // MARK: - TextField Delegate
     public func textFieldDidEndEditing(_ textField: UITextField)
     {
            particiantNo = Int64(textField.text!)!
     }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let numberOnly = NSCharacterSet.init(charactersIn: "0123456789")
        let stringFromTextField = NSCharacterSet.init(charactersIn: string)
        let strValid = numberOnly.isSuperset(of: stringFromTextField as CharacterSet)
        return strValid
    }
    
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
