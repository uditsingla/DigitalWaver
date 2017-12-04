//
//  AuthManager.swift
//  Relay
//
//  Created by Sourcefuse on 17/01/17.
//  Copyright © 2017 iOS. All rights reserved.
//

import UIKit
import CoreData

class AuthManager: NSObject {
    
    
    var arrCountry : NSMutableArray?
    var arrStates : NSMutableArray?
    
    override init()
    {
        arrCountry = NSMutableArray()
        arrStates = NSMutableArray()
    }
    
    
    func userSignUp(userInfo: [String : Any], handler : @escaping (UserI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "register", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                if(statusCode == 200){
                    
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess){
                        
                        self.resetUserDefaults()

                        handler(nil , true ,"User registered successfully")
                        
                    }else{
                        
                        handler(nil, false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }else{
                    
                    handler(nil, false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
                
                
        })
    }
    
    func userLogin(userInfo: [String : Any], handler : @escaping (UserI?, Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "login", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                // success code
                
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess)
                    {
                        print(userInfo)
                        
                        if((UserDefaults.standard.object(forKey: "userEmail")) != nil)
                        {
                            if((UserDefaults.standard.value(forKey: "userEmail") as! String) != (userInfo["email"] as! String))
                            {
                                self.resetUserDefaults()
                            }
                        }
                        else
                        {
                            UserDefaults.standard.set(userInfo["email"] as! String, forKey: "userEmail")
                        }
                        
                        handler(nil, true,(jsonDict.value(forKey: "message") as? String)!)
                    }
                    else
                    {
                         handler(nil, false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }
                else
                {
                    handler(nil, false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
              
                
        })
    }
    
    
    
    func setUserDefaultValues()
    {
        if (UserDefaults.standard.object(forKey: "dictWaversData") as? [String : Any]) != nil
        {

        }
        else
        {
            var dictData = [String : Any]()
            let arrMut : NSMutableArray = NSMutableArray()
            dictData["data"] = arrMut
            UserDefaults.standard.set(dictData, forKey: "dictWaversData")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    func resetUserDefaults()
    {
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        
        //Reset DB
        ModelManager.sharedInstance.waverManager.deleteAllDataFromDB()
        
        self.setUserDefaultValues()
    }
    
    
    
    
    
}
