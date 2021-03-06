//
//  SearchWaiverVC.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 10/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import SearchTextField
import SVProgressHUD
import ReachabilitySwift

class SearchWaiverVC: UIViewController {

    @IBOutlet weak var btnBacktoLogin: RoundedButton!
    @IBOutlet weak var txtSearch: SearchTextField!
    @IBOutlet weak var btnSynch: RoundedButton!
        
    var isSettingClicked = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let navButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        navButton.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
        //btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navButton.addTarget(self, action: #selector(actionSettings), for: .touchUpInside)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: navButton), animated: true);
        self.navigationItem.title = "Search Waiver"
        configureCustomSearchTextField()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Configure search text field
    fileprivate func configureCustomSearchTextField() {
        // Set theme - Default: light
        txtSearch.theme = SearchTextFieldTheme.darkTheme()
        
        // Define a header - Default: nothing
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: txtSearch.frame.width, height: 40))
        header.textAlignment = .center
        //header.font = UIFont(name: Constants.Fonts.sourceSansProRegular, size: 14)!
        header.text = "Choose Waiver"
        txtSearch.resultsListHeader = header
        
        // Modify current theme properties
        //txtSearch.theme.font = UIFont(name: Constants.Fonts.sourceSansProRegular, size: 14)!
        txtSearch.theme.fontColor = UIColor.black
        txtSearch.theme.bgColor = UIColor.white
        txtSearch.theme.cellHeight = 40
        //txtSearch.theme.placeholderColor = Constants.Colors.placeHolderColor
        //txtSearch.theme.separatorColor = Constants.Colors.placeHolderColor
        
        // Handle item selection - Default behaviour: item title set to the text field
        txtSearch.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            
            //Push
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let waiverVC = sb.instantiateViewController(withIdentifier: "AddParticipant") as! AddParticipant
            waiverVC.isWaverSelected = true
            
            // Do whatever you want with the picked item

            let arrData = item.title.split(separator: "-")
            waiverVC.strGroupName = String(arrData[0])

            self.txtSearch.text = item.subtitle
            self.txtSearch.resignFirstResponder()
            
            self.navigationController?.pushViewController(waiverVC, animated: true)
        }
        
        // Update data source when the user stops typing
        txtSearch.userStoppedTypingHandler = {
            if let criteria = self.txtSearch.text {
                if criteria.characters.count > 1 {
                    
                    // Show loading indicator
                    self.txtSearch.showLoadingIndicator()
                    
                    ModelManager.sharedInstance.waverManager.searchWaiver(searchString: criteria, handler: { (isSuccess, strMessage, arrResponse) in
                       
                        if(isSuccess)
                        {
                            let arr = arrResponse
                            var results = [SearchTextFieldItem]()
                            
                            for item in arr!{
                                results.append(SearchTextFieldItem(title: "\(item)"))
                            }
                            
                            // Set new items to filter
                            DispatchQueue.main.async {
                                
                                self.txtSearch.filterItems(results)
                                // Stop loading indicator
                            }
                        }
                        
                        self.txtSearch.stopLoadingIndicator()

                    })
                    
               
                }
            }
            } as (() -> Void)
    }
    
    // MARK: - Actions
    @objc func actionSettings()
    {
        if(isSettingClicked == true)
        {
            isSettingClicked = false
            btnSynch.isHidden = true
            btnBacktoLogin.isHidden = true
        }
        else
        {
            isSettingClicked = true
            btnSynch.isHidden = false
            btnBacktoLogin.isHidden = false
        }
    }
    
    @IBAction func actionBackToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSynch(_ sender: Any) {
        
        SVProgressHUD.show(withStatus: "Syncing")
        
        ModelManager.sharedInstance.waverManager.setDataToBesynchronise { (isSuccess, strMessage) in
        
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)

            if(isSuccess)
            {
                SVProgressHUD.showInfo(withStatus: strMessage)
            }
            else{
                SVProgressHUD.showError(withStatus: strMessage)
            }
            
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
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
