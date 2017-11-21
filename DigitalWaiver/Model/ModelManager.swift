//
//  ModelManager.swift
//  Relay
//
//  Created by sourcefuse on 17/01/17.
//  Copyright © 2017 iOS. All rights reserved.
//

import UIKit

class ModelManager: NSObject {
    
    var authManager:AuthManager
    var profileManager : ProfileManager
    var waverManager : WaverManager

    static let sharedInstance = ModelManager()
    
    fileprivate override init()
    {
        authManager = AuthManager()
        profileManager = ProfileManager()
        waverManager = WaverManager()
        
    }
    
}
