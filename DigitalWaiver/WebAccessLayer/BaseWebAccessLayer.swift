//
//  BaseWebAccessLayer.swift
//  Rezli
//
//  Created by Kabir Chandoke on 1/24/17.
//  Copyright © 2017 iOS. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SVProgressHUD

import ReachabilitySwift

class BaseWebAccessLayer: NSObject {
    
    static let reachability = Reachability()
    
    override init() {
        
        BaseWebAccessLayer.isInternetReachable { (isInternetAvailable, strMessage) in
            
            
        }
    }
    
    
    class func isInternetReachable(reachabilityHandler : @escaping (Bool,String) -> Void) -> Void
    {
        reachability?.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                reachabilityHandler(true,"")
                
                print("Internet Reachable")
                
            }
        }
        reachability?.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                print("Not reachable")
                reachabilityHandler(false,"No Internet Available")
            }
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    
    
    class func requestURLWithDictionaryResponse(requestType : HTTPMethod , strURL: String,headers : Bool,params : [String : Any]?, result:@escaping (NSDictionary , Int) -> Void) {
        if (reachability?.isReachable)!
        {
            // proceed
            
            SVProgressHUD.setStatus("Logging.....")
            
            var finalStrUrl = String()
            
            finalStrUrl = Constants.baseUrl + strURL
            
            let escapedUrl = finalStrUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            let headersHttp = [
                // "User-Agent" : "Mozilla/5.0 (iPhone; CPU iPhone OS 10_1_1 like Mac OS X) AppleWebKit/602.2.14 (KHTML, like Gecko) Version/10.0 Mobile/14B100 Safari/602.1",
                "Content-Type": "application/json"
            ]
            
            let alamofiremManager = Alamofire.SessionManager.default
            alamofiremManager.session.configuration.timeoutIntervalForRequest = 30
            
            alamofiremManager.request(escapedUrl!, method: requestType, parameters: params!, encoding: JSONEncoding.default, headers: headersHttp).responseJSON {  (responseObject) in
                
                print(responseObject.result)
                
                SVProgressHUD.dismiss()
                if responseObject.result.isSuccess {
                    let statusCode : Int = (responseObject.response?.statusCode)!
                    let resJson = responseObject.result.value as! NSDictionary
                    result(resJson , statusCode)
                }
            }
            
        }
        else
        {
            SVProgressHUD.showError(withStatus: "No Internet Available")
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)
            let resJson = NSMutableDictionary()
            resJson.setValue("No Internet Available", forKey: "message")

            result(resJson , 0)

        }
        
    }
    
    
    
    
    
    class func requestURLWithArrayResponse(requestType : HTTPMethod , strURL: String,headers : Bool,params : [String : Any]?, result:@escaping (NSArray , Int) -> Void) {
        
        
        if (reachability?.isReachable)!
        {
            // proceed
            
            SVProgressHUD.setStatus("Logging.....")
            
            var finalStrUrl = String()
            
            finalStrUrl = Constants.baseUrl + strURL
            
            let escapedUrl = finalStrUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            let headersHttp = [
                // "User-Agent" : "Mozilla/5.0 (iPhone; CPU iPhone OS 10_1_1 like Mac OS X) AppleWebKit/602.2.14 (KHTML, like Gecko) Version/10.0 Mobile/14B100 Safari/602.1",
                "Content-Type": "application/json"
            ]
            
            
            let alamofiremManager = Alamofire.SessionManager.default
            
            alamofiremManager.session.configuration.timeoutIntervalForRequest = 30
            
            if let prams = params
            {
                
                alamofiremManager.request(escapedUrl!, method: requestType, parameters: prams, encoding: JSONEncoding.default, headers: headersHttp).responseJSON {  (responseObject) in
                    
                    if responseObject.result.isSuccess {
                        
                        SVProgressHUD.dismiss()
                        let statusCode : Int = (responseObject.response?.statusCode)!
                        let arrResponse = responseObject.result.value as! NSArray
                        result(arrResponse , statusCode)
                        
                    }
                }
            }
            else
            {
                alamofiremManager.request(escapedUrl!, method: requestType, parameters: nil, encoding: JSONEncoding.default, headers: headersHttp).responseJSON {  (responseObject) in
                    
                    if responseObject.result.isSuccess {
                        
                        SVProgressHUD.dismiss()
                        let statusCode : Int = (responseObject.response?.statusCode)!
                        let arrResponse = responseObject.result.value as! NSArray
                        
                        result(arrResponse , statusCode)
                        
                    }
                }
                
            }
        }
        else
        {
            SVProgressHUD.showError(withStatus: "No Internet Available")
            SVProgressHUD.dismiss(withDelay: Constants.errorPopupTime)


        }
        
    }
}

