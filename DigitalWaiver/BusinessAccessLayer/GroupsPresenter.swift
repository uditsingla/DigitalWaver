//
//  GroupsPresenter.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 06/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.

//

import Foundation
import CoreData
import SystemConfiguration

protocol GroupView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func finishLoadingWithSuccess()
    func showError(withStatus: String)
    func dismissWithDelay(withDelay: Double)

}


class GroupsPresenter: NSObject {
    let managedObjectContext = AppSharedInstance.sharedInstance.managedObjectContext

    weak fileprivate var groupsView : GroupView?
    
    override init() {
    
    }
    
    func attachView(_ view:GroupView){
        groupsView = view
    }
    
    func detachView() {
        groupsView = nil
    }
    
    
    func getModelData() {
        
        
    }
    
    func getInitialData() {
        
    }
    
    func getNewData(email:String, password: String) {
        var  dictData : [String : Any] =  [String : Any]()
        dictData["email"] = email
        dictData["password"] = password
        self.groupsView?.startLoading()

        ModelManager.sharedInstance.authManager.userLogin(userInfo: dictData) { (userObj, isSuccess, strMessage) in
            
            
            if(isSuccess)
            {
                print("Login Done")
                
                ModelManager.sharedInstance.waverManager.getBuisnessName(participantInfo: nil, handler: { (isSuccess, strMessage) in
                    
                    if (isSuccess)
                    {
                        ModelManager.sharedInstance.authManager.setUserDefaultValues()
                        self.groupsView?.finishLoading()
                        self.groupsView?.finishLoadingWithSuccess()
                    }
                    else{
                        self.groupsView?.showError(withStatus: strMessage)
                        self.groupsView?.dismissWithDelay(withDelay: Constants.errorPopupTime)

                    }
                })
                //self.performSegue(withIdentifier: "goto_homeview", sender: nil)
                
            }
            else
            {
                self.groupsView?.showError(withStatus: strMessage)
                self.groupsView?.dismissWithDelay(withDelay: Constants.errorPopupTime)
                
            }
            
        }
    }
    
    
    func getRefreshDataWith(completion: @escaping (NSMutableArray) -> Void) {
        
    }
    
    func getRefreshData() {
        
    }
}
