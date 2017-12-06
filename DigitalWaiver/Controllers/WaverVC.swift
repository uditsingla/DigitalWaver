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
        var dictData = [String : Any]()
        dictData["businessname"] = UserDefaults.standard.string(forKey: "buisnessName")
        dictData["participants_no"] = "\(particiantNo)"
        dictData["group_name"] = txtGroupName.text
        dictData["isSynched"] = false

        if let a = dictData["businessname"]
        {
            let srtA = a as! String
            
            if let b = dictData["group_name"]
            {
                let srtB = b as! String

                dictData["link"] = "http://digital-waiver.appspot.com/viewwaiverform.html?businessname="+srtA+"&groupname="+srtB
            }
        }
        
        if(!ModelManager.sharedInstance.waverManager.SaveGroupDataInDB(groupData: dictData as NSDictionary))
        {
            SVProgressHUD.showError(withStatus: "Groupname already exists")
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)

            return
        }

        //APiHit
        let reach = Reachability()
        if let reachable : String = reach?.currentReachabilityString
        {
            if(reachable != "No Connection")
            {
                self.addParticiant(dictData: dictData,savedData: dictData as NSDictionary)
            }
            else
            {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "AddParticipant") as! AddParticipant
                vc.strGroupName = self.txtGroupName.text!
                vc.particiantNoChanged = particiantNo
                vc.particiantNo = particiantNo
                vc.isWaverSelected = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func addParticiant(dictData : [String : Any],savedData:NSDictionary)
    {
        SVProgressHUD.show(withStatus: "Loading.....")
        ModelManager.sharedInstance.waverManager.addWaver(userInfo: dictData, handler: { (isSuccess, strMessage) in
            SVProgressHUD.dismiss()
            
            if(isSuccess)
            {
                ModelManager.sharedInstance.waverManager.UpdateGroupDataInDB(groupDict: savedData)
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
