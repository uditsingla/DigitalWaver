//
//  WaverI.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 08/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class WaverI : NSObject {
    
    //setter and getters
    public var name: String?
    public var email : String?
    public var phoneNo: String?
    public var mimeType: String?
    public var signature: String?
    public var smsStatus: String?
    public var emailStatus: String?
    public var gender: String?
    public var age: String?
    public var isNewsletterSubscribe : Bool?
    public var signaturefileContent : String?

    
    override init() {
        
        self.name = ""
        self.email = ""
        self.phoneNo = ""
        self.mimeType = ""
        self.signature = ""
        self.smsStatus = ""
        self.emailStatus = ""
        self.gender = ""
        self.age = ""
        self.isNewsletterSubscribe = true
        self.signaturefileContent = ""
    }
    
    func resetData()
    {
        self.name = ""
        self.email = ""
        self.phoneNo = ""
        self.mimeType = ""
        self.signature = ""
        self.smsStatus = ""
        self.emailStatus = ""
        self.gender = ""
        self.age = ""
        self.isNewsletterSubscribe = true
        self.signaturefileContent = ""

    }
   

}
