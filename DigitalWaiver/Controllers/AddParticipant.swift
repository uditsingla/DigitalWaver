//
//  AddParticipant.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 06/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
//import EPSignature
import SVProgressHUD



class AddParticipant: UIViewController,UITableViewDelegate,UITableViewDataSource, UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIWebViewDelegate,YPSignatureDelegate {

    fileprivate let participentPresenter = ParticipentPresenter()

    // Connect this Outlet to the Signature View
    @IBOutlet weak var signatureView: YPDrawSignatureView!

    @IBOutlet weak var btnSubscription: UIButton!
    
    @IBOutlet weak var xConstarintOfClickToSign: NSLayoutConstraint!
    @IBOutlet weak var superOfUpdateParticipantsConstraint: NSLayoutConstraint!
    @IBOutlet weak var superOfMainViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var superOfInnerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerGender: UIPickerView!
    
    @IBOutlet weak var btnGender: RoundedButton!
    @IBOutlet weak var tblParticipants: UITableView!
    @IBOutlet weak var txtNoOfParticipants: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var viewWeb: UIView!
    
    @IBOutlet weak var viewWebView: UIWebView!
    
    @IBOutlet weak var btnUpdateParticipants: RoundedButton!
    @IBOutlet weak var btnSign: RoundedButton!

    @IBOutlet weak var viewSuperSignature: UIView!
    
    var gender = "Select"
    
    var isNewsletterSubscribe = true
    var sendFinalImage = ""
    
    var arrParticipants : NSMutableArray = NSMutableArray()

    var isWaverSelected = false
    var strGroupName = ""

    var particiantNo : Int64 = 0
    
    var particiantNoChanged : Int64 = 0
    
    var groupName : String = ""
    
    var pickerData: [String] = [String]()

    @IBOutlet weak var btnSignMinor: RoundedButton!
    
    @IBOutlet weak var viewSuperSubviews: UIView!
    
    @IBOutlet weak var viewSuperGender: UIView!
    
    // MARK: - Signature View Actions
    
    @IBAction func cancleSignature(_ sender: UIButton) {
        viewSuperSignature.isHidden = true
        self.signatureView.clear()
        
    }
    
    
    // Function for clearing the content of signature view
    @IBAction func clearSignature(_ sender: UIButton) {
        // This is how the signature gets cleared
        self.signatureView.clear()
    }
    
    // Function for saving signature
    @IBAction func saveSignature(_ sender: UIButton) {
        // Getting the Signature Image from self.drawSignatureView using the method getSignature().
        if let signatureImage = self.signatureView.getSignature(scale: 1) {
            
            // Saving signatureImage from the line above to the Photo Roll.
            // The first time you do this, the app asks for access to your pictures.
            //UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            
            
            let imageData = UIImageJPEGRepresentation(signatureImage, 0.5)
            
            self.sendFinalImage = (imageData?.base64EncodedString(options: .endLineWithLineFeed))!
            
            debugPrint(self.sendFinalImage)

            var dictData = [String : Any]()
            
            let userDefault = UserDefaults.standard
            dictData["businessname"] = userDefault.string(forKey: "buisnessName")
            dictData["groupname"] = groupName
            dictData["mimetype"] = "image/jpeg"
            dictData["filecontent"] = "\(self.sendFinalImage)"
            dictData["filename"] = "signature.jpg"
            dictData["phoneno"] = "\(self.txtPhone.text!)"
            dictData["email"] = "\(self.txtEmail.text!)"
            dictData["name"] = "\(self.txtName.text!)"
            dictData["newsletter"] = "\(isNewsletterSubscribe)"
            dictData["age"] = "\(self.txtAge.text!)"
            dictData["gender"] = "\(gender)"
            
            if(btnSignMinor.currentTitle == "Sign Major")
            {
                dictData["phoneno"] = " "
                dictData["email"] = " "
                dictData["age"] = " "
                dictData["gender"] = " "
            }
            
            if(gender == "Select")
            {
                dictData["gender"] = " "
            }
            
            print(dictData)
            
            
//            local db
            ModelManager.sharedInstance.waverManager.SaveParticipentDataInDB(participentData: dictData as NSDictionary)
//            push
            DispatchQueue.main.async {
                self.participentPresenter.attachView(self as ParticipentView)
                self.participentPresenter.addNewParticipant(participantInfo: dictData)
                
            }
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.

            self.signatureView.clear()
        }
    }
    
    // MARK: - Delegate Methods
    
    // The delegate functions gives feedback to the instanciating class. All functions are optional,
    // meaning you just implement the one you need.
    
    // didStart() is called right after the first touch is registered in the view.
    // For example, this can be used if the view is embedded in a scroll view, temporary
    // stopping it from scrolling while signing.
    func didStart() {
        print("Started Drawing")
    }
    
    // didFinish() is called rigth after the last touch of a gesture is registered in the view.
    // Can be used to enabe scrolling in a scroll view if it has previous been disabled.
    func didFinish() {
        print("Finished Drawing")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signatureView.delegate = self

        signatureView.layer.borderColor = UIColor.gray.cgColor
        signatureView.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
        btnUpdateParticipants.isHidden = true
        
        superOfUpdateParticipantsConstraint.constant = 60
        //xConstarintOfClickToSign.constant = 488

        
        self.pickerGender.delegate = self
        self.pickerGender.dataSource = self

        
        pickerData = ["Select","Male", "Female"]
        
        tblParticipants.tableFooterView = UIView()
        tblParticipants.rowHeight = UITableViewAutomaticDimension

        
        txtPhone.text = "+1"
        if(isWaverSelected == true)
        {
            print("Get waiver detail")
            getWaiverDetail()
        }
        
        viewWebView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Actions
    
    @IBAction func actionIAgree(_ sender: UIButton) {
        
        sender.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        viewWeb.isHidden = true
        
    }
    
    @IBAction func actionCross(_ sender: UIButton) {
        viewWeb.isHidden = true
        
        viewWebView.stopLoading()

    }
    
    
    @IBAction func actionViewWaiver(_ sender: RoundedButton) {
        
        viewWeb.isHidden = false
        
        let userDefault = UserDefaults.standard

        let urlStr = "\(Constants.baseUrl)previewwaiver.html?businessname=\(userDefault.string(forKey: "buisnessName")!)&groupname=\(strGroupName)"
        
        let urlwithPercentEscapes = urlStr.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)

        print(urlwithPercentEscapes!)
        if let url = URL(string: urlwithPercentEscapes!) {
            let request = URLRequest(url: url)
            viewWebView.loadRequest(request)
        }
    }

    
    
    @IBAction func actionUpdateParticipants(_ sender: RoundedButton) {
        
        resignAllResponder()

        var dictData = [String : Any]()
        dictData["participants_no"] = "\(particiantNoChanged)"
        dictData["group_name"] = groupName
        print(dictData)
        ModelManager.sharedInstance.waverManager.updateParticipant(participantInfo: dictData) { (isSuccess, strMessage) in
            
            self.particiantNo = self.particiantNoChanged
            self.updateUI()
            
            SVProgressHUD.showSuccess(withStatus: strMessage)
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
        }
    }
    @IBAction func actionAdd(_ sender: RoundedButton) {
        
        resignAllResponder()
        
        particiantNoChanged = particiantNoChanged + 1
        txtNoOfParticipants.text = "\(particiantNoChanged)"
        
        updateUI()

    }
    
    @IBAction func actionSubtract(_ sender: RoundedButton) {
        if(particiantNoChanged > 0)
        {
            resignAllResponder()

            particiantNoChanged = particiantNoChanged - 1
            txtNoOfParticipants.text = "\(particiantNoChanged)"
            
            updateUI()
        }
    }
    
    func updateUI() {
        if((particiantNoChanged != particiantNo) && (isWaverSelected))
        {
            btnUpdateParticipants.isHidden = false
            superOfUpdateParticipantsConstraint.constant = 130
        }
        else
        {
            btnUpdateParticipants.isHidden = true
            superOfUpdateParticipantsConstraint.constant = 60
        }
    }
    
    @IBAction func actionAddSignature(_ sender: RoundedButton) {
        
        if(arrParticipants.count < particiantNo)
        {
            if(btnSignMinor.currentTitle == "Sign Minor")
            {
                let strMessage = Validations.validateAddParticipants(fullName: txtName.text!, email: txtEmail.text!, phoneNo: txtPhone.text!)
                
                if(strMessage != "")
                {
                    SVProgressHUD.showError(withStatus: strMessage)
                    SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
                    return
                }
            }
            else
            {
                
                if(txtName.text == "" || txtName.text == " ")
                {
                    SVProgressHUD.showError(withStatus: "Please enter name")
                    SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
                    return
                }
            }
            
            viewSuperSignature.isHidden = false

            
            //let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
            //signatureVC.title = "Signature"
            
//            let nav = UINavigationController(rootViewController: signatureVC)
//            present(nav, animated: true, completion: nil)
        }
        else
        {
            SVProgressHUD.showInfo(withStatus: "Please add/update participants")
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
            
        }
    }
    
    @IBAction func actionBtnGender(_ sender: RoundedButton) {
        
        pickerGender.isHidden = false
    }
    

    @IBAction func actionMinor(_ sender: RoundedButton) {
        
        if(btnSignMinor.currentTitle == "Sign Major")
        {
            xConstarintOfClickToSign.constant = 9
            superOfInnerViewHeightConstraint.constant = 128
            superOfMainViewConstraint.constant = 289
            btnSign.setTitle("Click to Sign", for: .normal)
            btnSignMinor.setTitle("Sign Minor", for: .normal)
            showSuperViews()
        }
        else
        {
            xConstarintOfClickToSign.constant = 250
            superOfInnerViewHeightConstraint.constant = 30
            superOfMainViewConstraint.constant = 190
                
            btnSign.setTitle("Parent Signature", for: .normal)
            btnSignMinor.setTitle("Sign Major", for: .normal)
            hideSuperViews()
        }
    }
    
    
    @IBAction func actionViewSignature(_ sender: UIButton) {
        
        print("view sign")

        let buttonPosition = sender.convert(CGPoint.zero, to: self.tblParticipants)
        let indexPath = self.tblParticipants.indexPathForRow(at:buttonPosition)
        if let indexPath = indexPath?.row
        {
            print(indexPath)
            viewWeb.isHidden = false
            
            
            let urlStr = "\(Constants.baseUrl)getsignature?signature_url=\(((arrParticipants.object(at: indexPath) as? WaverI)?.signature)!)&mimetype=\(((arrParticipants.object(at: indexPath) as? WaverI)?.mimeType)!)"
            
            print(urlStr)
            
            if let url = URL(string: urlStr) {
                let request = URLRequest(url: url)
                viewWebView.loadRequest(request)
            }
        }
    }
    
    
    func addParticiant()  {
        
        print(UserDefaults.standard.object(forKey: "arrayDictData") as! NSArray)
        //API Hit
        //        ModelManager.sharedInstance.waverManager.addNewParticipant(participantInfo: dictData) { (isSuccess, strMessage) in
        //
        self.resetData()
        self.getWaiverDetail()
        //        }
    }
    
    // MARK: - TextField Delegate
    public func textFieldDidEndEditing(_ textField: UITextField)
    {
        if(textField == txtNoOfParticipants)
        {
            particiantNoChanged = Int64(textField.text!)!
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == txtPhone)
        {
            let numberOnly = NSCharacterSet.init(charactersIn: "+0123456789")
            let stringFromTextField = NSCharacterSet.init(charactersIn: string)
            let strValid = numberOnly.isSuperset(of: stringFromTextField as CharacterSet)
            return strValid
        }
        else if (textField == txtAge)
        {
            let numberOnly = NSCharacterSet.init(charactersIn: "0123456789")
            let stringFromTextField = NSCharacterSet.init(charactersIn: string)
            let strValid = numberOnly.isSuperset(of: stringFromTextField as CharacterSet)
            return strValid
        }
        
        return true
    }
    
    // MARK: - Custom Functions

    func resetData()
    {
        txtName.text = ""
        txtAge.text = ""
        txtEmail.text = ""
        txtPhone.text = "+1"
        btnGender.setTitle("Select", for: .normal)
        
        gender = "Select"
        pickerGender.reloadAllComponents()
        
    }
    
    func resignAllResponder()  {
        self.view.endEditing(true)
    }
    
    func hideSuperViews()
    {
        viewSuperGender.isHidden = true
        viewSuperSubviews.isHidden = true
    }
    
    func showSuperViews()
    {
        viewSuperGender.isHidden = false
        viewSuperSubviews.isHidden = false
    }
    
    func getWaiverDetail()
    {
        var  dictData : [String : Any] =  [String : Any]()
        let userDefault = UserDefaults.standard
        dictData["businessname"] = userDefault.string(forKey: "buisnessName")
        dictData["group_name"] = strGroupName
        
        ModelManager.sharedInstance.waverManager.getWaverDetail(waverDetail: dictData, handler: { (isSuccess, strMessage, dictWaiverInfo, arrResponse) in
            
            if let dictWaiverInfo = dictWaiverInfo
            {
                self.txtNoOfParticipants.text = dictWaiverInfo["participantno"] as? String
            
            //Set Number of Particapants from Server
                self.particiantNo = Int64((dictWaiverInfo["participantno"] as? String)!)!
                self.groupName = (dictWaiverInfo["groupname"] as? String)!
            
            self.particiantNoChanged = self.particiantNo
            self.updateUI()
            
            self.arrParticipants.removeAllObjects()
            self.arrParticipants.addObjects(from: arrResponse as! [WaverI])
               

            self.tblParticipants.reloadData()
            }
            
        })
    }

    
    //MARK: - Webview Delegates
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Webview finish loading");
        
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Webview fail with error \(error)");
        SVProgressHUD.dismiss()

    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Webview started Loading")
        
        SVProgressHUD.show()
    }

    
    

    /*
    func epSignature(_: EPSignature.EPSignatureViewController, didCancel error: NSError)
    {
        print("Cancel")
    }
    
    func epSignature(_: EPSignature.EPSignatureViewController, didSign signatureImage: UIImage, boundingRect: CGRect)
    {
     
    }
 
 func epSignature(_: EPSignatureViewController, isSubscriptionRequired : Bool)
 {
 isNewsletterSubscribe = isSubscriptionRequired
 }
 
 */
    
    // MARK: - Signature Delegates
    @IBAction func setSubscription(_ sender: UIButton) {
        
        if(isNewsletterSubscribe)
        {
            isNewsletterSubscribe = false
            btnSubscription.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
        }
        else
        {
            isNewsletterSubscribe = true
            btnSubscription.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        }
    }
    
    
    // MARK: - Local Storage
    func saveDataInLocalDB(dictData : [String : Any])
    {
        let userDefault = UserDefaults.standard
        let arrMutable = (UserDefaults.standard.object(forKey: "arrayDictData") as! NSArray).mutableCopy() as! NSMutableArray
        
        var dictData = [String : String]()
        dictData["businessname"] = userDefault.string(forKey: "buisnessName")
        dictData["groupname"] = groupName
        dictData["mimetype"] = "image/jpeg"
        dictData["filecontent"] = "\(self.sendFinalImage)"
        dictData["filename"] = "signature.jpg"
     
        dictData["name"] = "\(self.txtName.text!)"
        dictData["newsletter"] = "\(isNewsletterSubscribe)"
        dictData["age"] = "\(self.txtAge.text!)"
        dictData["gender"] = "\(gender)"
        
        arrMutable.add(dictData)
        
        UserDefaults.standard.set(arrMutable, forKey: "arrayDictData")
        
        
        //APiHit
        self.addParticiant()
        
    }
    
    // MARK: - TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrParticipants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WaiverCell", for: indexPath) as! WaiverCell
        
        cell.lblName.text = (arrParticipants.object(at: indexPath.row) as? WaverI)?.name
        cell.lblEmail.text = (arrParticipants.object(at: indexPath.row) as? WaverI)?.email
        cell.lblPhone.text = (arrParticipants.object(at: indexPath.row) as? WaverI)?.phoneNo
        cell.lblAge.text = (arrParticipants.object(at: indexPath.row) as? WaverI)?.age
        cell.lblGender.text = (arrParticipants.object(at: indexPath.row) as? WaverI)?.gender

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // MARK: - Picker Delegates
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        gender = pickerData[row]
        btnGender.setTitle(gender, for: .normal)
        pickerGender.isHidden = true
        return   pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        gender = pickerData[row]
        
        let myTitle = NSAttributedString(string: gender, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedStringKey.foregroundColor:UIColor.black])
        
        pickerGender.isHidden = true
        btnGender.setTitle(gender, for: .normal)
        return myTitle
    }
    

}

extension AddParticipant: ParticipentView {
    func startLoading() {
        SVProgressHUD.show(withStatus: "Loading.....")
        
    }
    
    func finishLoading() {
        SVProgressHUD.dismiss()
        self.viewSuperSignature.isHidden = true
        self.sendFinalImage = ""
        self.resetData()
        self.getWaiverDetail()

    }
    
    func finishLoadingWithSuccess() {
        
    }
    
    
    func showError(withStatus: String) {
        SVProgressHUD.showInfo(withStatus: withStatus)
    }
    
    func dismissWithDelay(withDelay: Double) {
        SVProgressHUD.dismiss(withDelay: withDelay)
    }
}
