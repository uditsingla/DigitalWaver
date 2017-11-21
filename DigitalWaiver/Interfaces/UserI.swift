//
//  UserI.swift
//  Abkao
//
//  Created by Abhishek Singla on 11/06/17.
//  Copyright © 2017 Abkao. All rights reserved.
//

import UIKit

class UserI: NSObject,NSCoding {
    
    //setter and getters
    public var email: String?
    public var firstName: String?
    public var lastName: String?
    public var password: String?
    public var accountName: String?
    public var accountNo: String?
    public var address: String?
    public var city: String?
    public var state: String?
    public var zip: String?
    public var country: String?
    public var telephone: String?
    public var username: String?
    public var userID: Int?
//    public var imageGridSize: Int?
//    public var priceGridSize: Int?
//    public var defaultUrl : String?
    
    
    override init(){
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.password = ""
        self.accountName = ""
        self.accountNo = ""
        self.address = ""
        self.city = ""
        self.state = ""
        self.zip = ""
        self.country = ""
        self.telephone = ""
        self.username = ""
//        self.defaultUrl = ""
//        self.imageGridSize = 0
//        self.priceGridSize = 0
        self.userID = 0
    }
    
    
    func resetData(){
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.password = ""
        self.accountName = ""
        self.accountNo = ""
        self.address = ""
        self.city = ""
        self.state = ""
        self.zip = ""
        self.country = ""
        self.telephone = ""
        self.username = ""
        self.userID = 0
//        self.defaultUrl = ""
//        self.imageGridSize = 0
//        self.priceGridSize = 0
    }
    
    
    required init(coder decoder: NSCoder) {
        self.email = decoder.decodeObject(forKey: "email") as? String ?? ""
        self.firstName = decoder.decodeObject(forKey: "firstName") as? String ?? ""
        self.lastName = decoder.decodeObject(forKey: "lastName") as? String ?? ""
        self.password = decoder.decodeObject(forKey: "password") as? String ?? ""
        self.accountName = decoder.decodeObject(forKey: "accountName") as? String ?? ""
        self.accountNo = decoder.decodeObject(forKey: "accountNo") as? String ?? ""
        self.address = decoder.decodeObject(forKey: "address") as? String ?? ""
        self.city = decoder.decodeObject(forKey: "city") as? String ?? ""
        self.state = decoder.decodeObject(forKey: "state") as? String ?? ""
        self.zip = decoder.decodeObject(forKey: "zip") as? String ?? ""
        self.country = decoder.decodeObject(forKey: "country") as? String ?? ""
        self.telephone = decoder.decodeObject(forKey: "telephone") as? String ?? ""
        self.username = decoder.decodeObject(forKey: "username") as? String ?? ""
        //self.defaultUrl = decoder.decodeObject(forKey: "defaultUrl") as? String ?? ""
        self.userID = decoder.decodeObject(forKey: "userID") as? Int ?? decoder.decodeInteger(forKey: "userID")
        //self.priceGridSize = decoder.decodeObject(forKey: "priceGridSize") as? Int ?? decoder.decodeInteger(forKey: "priceGridSize")
        //self.imageGridSize = decoder.decodeObject(forKey: "imageGridSize") as? Int ?? decoder.decodeInteger(forKey: "imageGridSize")
    }
    
    
    func encode(with coder: NSCoder) {
        coder.encode(email, forKey: "email")
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(password, forKey: "password")
        coder.encode(accountName, forKey: "accountName")
        coder.encode(accountNo, forKey: "accountNo")
        coder.encode(address, forKey: "address")
        coder.encode(city, forKey: "city")
        coder.encode(state, forKey: "state")
        coder.encode(zip, forKey: "zip")
        coder.encode(country, forKey: "country")
        coder.encode(telephone, forKey: "telephone")
        coder.encode(username, forKey: "username")
        //coder.encode(defaultUrl, forKey: "defaultUrl")
        coder.encode(userID, forKey: "userID")
        //coder.encode(priceGridSize, forKey: "priceGridSize")
        //coder.encode(imageGridSize, forKey: "imageGridSize")
    }
    
    public func setUserInfo(userObj : [String : AnyObject])
    {
                
        //let arrData : NSArray = userObj["userdetails"] as! NSArray
        let dictData : [String : AnyObject]  = userObj["userdetails"] as! [String : AnyObject]
        
        self.userID = dictData["userid"] as? Int
        self.accountName = dictData["account_name"] as? String ?? ""
        self.accountNo =   dictData["account_number"] as? String ?? ""
        self.password = dictData["password"] as? String ?? ""

    }
    

}
