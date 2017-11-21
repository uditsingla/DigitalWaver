//
//  WaverManager.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 08/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class WaverManager: NSObject {

    func addWaver(userInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "quickwaiversync", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                
                // success code
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess)
                    {
                        var dictData = [String : Any]()
                        let arrMut : NSMutableArray = NSMutableArray()
                        dictData["data"] = arrMut
                        UserDefaults.standard.set(dictData, forKey: "dictWaversData")
                        UserDefaults.standard.synchronize()
                        
                        handler(true ,"Waiver Created Successfully")
                    }
                    else
                    {
                        handler(false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }
                else
                {
                    handler(false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
        })
    }
    
    func getWaverDetail(waverDetail: [String : Any], handler : @escaping (Bool, String, [String : Any]?, NSArray?) -> Void)
    {
        BaseWebAccessLayer.requestURLWithArrayResponse(requestType: .post, strURL: "getexistingdata", headers: true, params: waverDetail, result:
            {
                (arrayResponse,statusCode) in
                
                print(arrayResponse)
                // success code
                if(statusCode == 200)
                {
                    let arrData : NSMutableArray = NSMutableArray()
                    var dictData = [String : Any]()
                    
                    if(arrayResponse.count > 0)
                    {
                        for (index, element) in arrayResponse.enumerated() {
                            if(index == 0)
                            {
                                dictData = element as! [String : Any]
                                print(dictData)
                            }
                            else
                            {
                               let dictData = element as! [String : Any]

                                let waverObj = WaverI()
                                waverObj.name = (dictData["Name"] as? String)?.capitalized
                                waverObj.email = dictData["Email"] as? String
                                waverObj.phoneNo = dictData["Phoneno"] as? String
                                waverObj.mimeType = dictData["MimeType"] as? String
                                waverObj.signature = dictData["SignatureUrl"] as? String
                                waverObj.smsStatus = dictData["SMSStatus"] as? String
                                waverObj.emailStatus = dictData["EmailStatus"] as? String
                                waverObj.gender = (dictData["Gender"] as? String)?.capitalized
                                waverObj.age = dictData["Age"] as? String

                                arrData.add(waverObj)
                            }
                        }
                        
                        handler(true ,"data received", dictData, arrData)
                    }
                    else
                    {
                        handler(false,"no data found",nil, nil)
                    }
                }
                else
                {
                    handler(false,"no data found",nil, nil)
                }
                
        })
    }
    
    
    func searchWaiver(searchString : String, handler : @escaping (Bool , String, NSArray?) -> Void)
    {
        BaseWebAccessLayer.requestURLWithArrayResponse(requestType: .get, strURL: "getsuggetions?input=\(searchString)", headers: true, params: nil, result:
            {
                (arrayResponse,statusCode) in
                
                print(arrayResponse)
                // success code
                if(statusCode == 200)
                {
                    if(arrayResponse.count > 0)
                    {
                        handler(true ,"data received",arrayResponse)
                    }
                    else
                    {
                        handler(false,"no data found", nil)
                    }
                }
                else
                {
                    handler(false,"no data found", nil)
                }
                
        })
    }
    
    func updateParticipant(participantInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "updateparticipantno", headers: true, params: participantInfo, result:
            {
                (jsonDict,statusCode) in
                
                // success code
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess)
                    {
                        handler(true ,"Participants Updated Successfully")
                    }
                    else
                    {
                        handler(false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }
                else
                {
                    handler(false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
        })
    }
    
    func addNewParticipant(participantInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "savewaiverform", headers: true, params: participantInfo, result:
            {
                (jsonDict,statusCode) in
                
                // success code
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess)
                    {
                        handler(true, (jsonDict.value(forKey: "message") as? String)!)
                    }
                    else
                    {
                        handler(false,(jsonDict.value(forKey: "message") as? String)!)
                    }
                }
                else
                {
                    handler(false,(jsonDict.value(forKey: "message") as? String)!)
                }
                
        })
    }
    
    func getBuisnessName(participantInfo: [String : Any]?, handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithArrayResponse(requestType: .post, strURL: "getwaiverdetails", headers: true, params: nil) { (arrResponse, statusCode) in
            // success code
            debugPrint(arrResponse)
            if(statusCode == 200)
            {
                if(arrResponse.count > 0)
                {
                let dictData = arrResponse.object(at: 0) as! [String : AnyObject]
                print(dictData)
                let userDefault = UserDefaults.standard
                userDefault.set(dictData["BusinessName"], forKey: "buisnessName")
                userDefault.synchronize()
                
                handler(true, "Buisness name has been set")
                }
                else
                {
                    handler(false,"Please add buissness from web portal fisrt")

                }
            }
            else
            {
                handler(false,"Please add buissness from web portal fisrt")
            }
        }
    }

}