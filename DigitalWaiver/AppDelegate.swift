//
//  AppDelegate.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 05/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ReachabilitySwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //set keyboard settings, we are using IQKeyboardmanager to handle keyboard everywhere
        setAppKeyboard()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        let reach = Reachability()
        
        if let dictData = UserDefaults.standard.object(forKey: "dictWaversData") as? [String : Any]
        {
            if let arrData = dictData["data"]
            {
                if let reachable : String = reach?.currentReachabilityString
                {
                    if(reachable != "No Connection")
                    {
                        if((arrData as! NSArray).count > 0)
                        {
                            
                            ModelManager.sharedInstance.waverManager.addWaver(userInfo: dictData, handler: { (isSuccess, strMessage) in
                                
                                if(isSuccess)
                                {
                                    if (UserDefaults.standard.object(forKey: "dictWaversData") as? [String : Any]) != nil
                                    {
                                        var dictData = [String : Any]()
                                        let arrMut : NSMutableArray = NSMutableArray()
                                        dictData["data"] = arrMut
                                        UserDefaults.standard.set(dictData, forKey: "dictWaversData")
                                        UserDefaults.standard.synchronize()
                                    }
                                }
                                else
                                {
                                    print("unable to save data in app delegate")
                                }
                            })
                        }
                    }
                }
                
            }
        }

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func setAppKeyboard(){
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldShowToolbarPlaceholder = false
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }


}

