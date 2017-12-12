//
//  WaverManager.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 08/11/17.
//  Copyright © 2017 Abhishek. All rights reserved.
////

import UIKit
import CoreData
import ReachabilitySwift

class WaverManager: NSObject {
    
    var waverHTMLContent : String?
    
    override init()
    {
        waverHTMLContent  = ""
    }
    
    let managedObjectContext = AppSharedInstance.sharedInstance.managedObjectContext
    var groupModelEntity: NSManagedObject? = nil

    func addWaver(userInfo: [String : Any], handler : @escaping (Bool , String) -> Void)
    {
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "quickwaiver", headers: true, params: userInfo, result:
            {
                (jsonDict,statusCode) in
                
                // success code
                if(statusCode == 200)
                {
                    let isSuccess = jsonDict.value(forKey: "success") as! Bool
                    
                    if(isSuccess)
                    {
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
            //debugPrint(arrResponse)
            if(statusCode == 200)
            {
                if(arrResponse.count > 0)
                {
                let dictData = arrResponse.object(at: 0) as! [String : AnyObject]
                //print(dictData)
                    
                //Set Waver Content
                ModelManager.sharedInstance.waverManager.waverHTMLContent = dictData["Content"] as? String
                    
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
    
    func synchDataOnServer(synchData: [String : Any], handler : @escaping (Bool , String) -> Void){
        BaseWebAccessLayer.requestURLWithDictionaryResponse(requestType: .post, strURL: "waiverparticipantsync", headers: true, params: synchData, result:
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

    // MARK: Coredata Methods

    func SaveGroupDataInDB (groupData:NSDictionary) -> Bool {
        let predicate = NSPredicate(format: "groupname==%@", groupData.value(forKey: "group_name") as! CVarArg)
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Groups")
        fetchRequest.predicate = predicate
        let result = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = result
        
        if ((resultData?.count)! == 0) {
            
        print("groupData == \(groupData)")
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Groups", in: self.managedObjectContext)
        
        let groupModelEntity1 = NSManagedObject(entity: entityDescription!, insertInto: managedObjectContext) as! Groups
        groupModelEntity1.buisness = groupData.value(forKey: "businessname") as? String
        groupModelEntity1.groupname = groupData.value(forKey: "group_name") as? String
        groupModelEntity1.waverlink = groupData.value(forKey: "link") as? String
        groupModelEntity1.participantsno = groupData.value(forKey: "participants_no") as? String
        groupModelEntity1.issynched = groupData.value(forKey: "isSynched") as! Bool

        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    
        self.groupModelEntity = groupModelEntity1
            
            return true
        }
        else
        {
            return false
        }
    }
    
    func UpdateGroupDataInDB (groupDict:NSDictionary) {
        
        let predicate = NSPredicate(format: "groupname==%@", groupDict.value(forKey: "group_name") as! CVarArg)

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Groups")
        fetchRequest.predicate = predicate
        let result = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = result
        
        if ((resultData?.count)! > 0) {
            for object in resultData! {
                let participentModelEntity1 = object as! Groups
                participentModelEntity1.issynched = true
                
            }
            do {
                try self.managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }

    //******************************************************************************************************************************************
    // MARK: remove data if exists in Coredata
    
    
    func deleteAllDataFromDB()
    {
        for entityName in ["Groups","Participants"]{
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do {
                try self.managedObjectContext.execute(deleteRequest)
                try self.managedObjectContext.save()
            } catch {
                print ("There was an error")
            }
        }
    }
    
    func removeIfDataExistForProfileId (dataID: String, withPredicate: NSPredicate, forEntityName: String) {
        print("removeIfDataExistForProfileId")
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: forEntityName)
        
        let result = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = result
        
        if ((resultData?.count)! > 0) {
            for object in resultData! {
                self.managedObjectContext.delete(object)
            }
            do {
                try self.managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func SaveParticipentDataInDB (participentData:NSDictionary) {

        print("participentData == \(participentData)")
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Participants", in: self.managedObjectContext)
        
        let participentModelEntity1 = NSManagedObject(entity: entityDescription!, insertInto: managedObjectContext) as! Participants
        participentModelEntity1.age = participentData.value(forKey: "age") as? String
        participentModelEntity1.businessname = participentData.value(forKey: "businessname") as? String
        participentModelEntity1.email = participentData.value(forKey: "email") as? String
        participentModelEntity1.filecontent = participentData.value(forKey: "filecontent") as? String
        participentModelEntity1.issynched = false
        participentModelEntity1.filename = participentData.value(forKey: "filename") as? String
        participentModelEntity1.gender = participentData.value(forKey: "gender") as? String
        participentModelEntity1.groupname = participentData.value(forKey: "groupname") as? String
        participentModelEntity1.mimetype = participentData.value(forKey: "mimetype") as? String
        participentModelEntity1.name = participentData.value(forKey: "name") as? String
        if participentData.value(forKey: "newsletter") as! String == "true" {
            participentModelEntity1.newsletter = true
        }
        else {
            participentModelEntity1.newsletter = false
        }

        participentModelEntity1.participantsNo = participentData.value(forKey: "participants_no") as? String
        participentModelEntity1.phoneno = participentData.value(forKey: "phoneno") as? String

        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func UpdateParticipentDataInDB(participentData:NSDictionary) {
        
        let predicate1:NSPredicate = NSPredicate(format: "groupname==%@", participentData.value(forKey: "groupname") as! CVarArg)
        let predicate2:NSPredicate = NSPredicate(format: "name==%@", participentData.value(forKey: "name") as! CVarArg)
        let predicate:NSPredicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2] )
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Participants")
        fetchRequest.predicate = predicate
        let result = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = result
        
        if ((resultData?.count)! > 0) {
            for object in resultData! {
                let participentModelEntity1 = object as! Participants
                participentModelEntity1.issynched = true

            }
            do {
                try self.managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    
    //Update Participants Count Only
    func updateParticipantsCountInDb(participentData:NSDictionary) -> Bool {
        let predicate : NSPredicate = NSPredicate(format: "groupname==%@", participentData.value(forKey: "group_name") as! String)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Groups")
        fetchRequest.predicate = predicate
        let result = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = result
        
        if ((resultData?.count)! > 0) {
            for object in resultData! {
                let groupEntity = object as! Groups
                groupEntity.participantsno = participentData.value(forKey: "participants_no") as? String
            }
            do {
                try self.managedObjectContext.save()
                return true
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                return false
            }
        }
        return false
    }
    
    //get Records from DB
    func getallparticipants(groupName : String) -> NSMutableArray?
    {
        let predicate : NSPredicate = NSPredicate(format: "groupname == %@", groupName)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Participants")
        fetchRequest.predicate = predicate
        let result = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = result
        
        if ((resultData?.count)! > 0)
        {
            let arrData : NSMutableArray = NSMutableArray()

            //print(resultData)
            for object in resultData! {
                
                let participantEntity = object as! Participants
                let waverObj = WaverI()
                waverObj.gender = participantEntity.gender
                waverObj.age = participantEntity.age
                waverObj.name = participantEntity.name
                waverObj.email = participantEntity.email
                waverObj.phoneNo = participantEntity.phoneno
                waverObj.signaturefileContent = participantEntity.filecontent
                arrData.add(waverObj)
            }
            return arrData
        }
        return nil
    }
    
    
    //Get all Offline Groups from DB
    func getAllGroups() -> NSMutableArray?
    {   
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Groups")
//        let predicate : NSPredicate = NSPredicate(format: "issynched == false")
//        fetchRequest.predicate = predicate
        let result = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = result
        
        if ((resultData?.count)! > 0)
        {
            let arrData : NSMutableArray = NSMutableArray()
            
            //print(resultData)
            for object in resultData! {
                let groupEntity = object as! Groups
                let groupObj = GroupI()
                groupObj.groupName = groupEntity.groupname
                groupObj.businessname = groupEntity.buisness
                groupObj.link = groupEntity.waverlink
                groupObj.participantNo = groupEntity.participantsno
                if(groupEntity.issynched)
                {
                    groupObj.isNewGroup = false
                }
                else
                {
                    groupObj.isNewGroup = true

                }
                arrData.add(groupObj)
            }
            return arrData
        }
        return nil
    }
    
    //Get all Offline Participants
    func getallOfflineparticipants(groupName : String) -> NSMutableArray?
    {
        
        let predicate1 : NSPredicate = NSPredicate(format: "groupname == %@", groupName)
        let predicate2 : NSPredicate = NSPredicate(format: "issynched == false")
        let predicate:NSPredicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2] )
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Participants")
        fetchRequest.predicate = predicate
        let result = try? self.managedObjectContext.fetch(fetchRequest)
        let resultData = result
        
        if ((resultData?.count)! > 0)
        {
            let arrData : NSMutableArray = NSMutableArray()
            
            //print(resultData)
            for object in resultData! {
                
                let participantEntity = object as! Participants
                let waverObj = WaverI()
                waverObj.gender = participantEntity.gender
                waverObj.age = participantEntity.age
                waverObj.name = participantEntity.name
                waverObj.email = participantEntity.email
                waverObj.phoneNo = participantEntity.phoneno
                waverObj.signaturefileContent = participantEntity.filecontent
                waverObj.isNewsletterSubscribe = participantEntity.newsletter
                
                arrData.add(waverObj)
            }
            return arrData
        }
        return nil
    }
    
    
    func setDataToBesynchronise(handler : @escaping (Bool , String) -> Void) {
        
        var dictData = [String : Any]()
        var groupInfo = [String : Any]()
        
        var arrGroupInfo = [[String : Any]]()
        
        //Get Offline saved Data From DB
        if let arrayGroups = ModelManager.sharedInstance.waverManager.getAllGroups()
        {
            print(arrayGroups)
            if(arrayGroups.count > 0)
            {
                for groupObj in arrayGroups
                {
                    let group = groupObj as! GroupI
                    
                    var dictGroupInfo = [String : Any]()
                    dictGroupInfo["businessname"] = group.businessname
                    dictGroupInfo["link"] = group.link
                    dictGroupInfo["participants_no"] = group.participantNo
                    dictGroupInfo["group_name"] = group.groupName
                    dictGroupInfo["isNewGroup"] = group.isNewGroup
                    
                    print(dictGroupInfo)
                    
                    if let arrParticpants =  ModelManager.sharedInstance.waverManager.getallOfflineparticipants(groupName: group.groupName!)
                    {
                        if(arrParticpants.count > 0)
                        {
                            var arrGroupParicipants = [[String : Any]]()
                            
                            for participantObj in arrParticpants
                            {
                                let participant = participantObj as! WaverI
                                //For loop as of No. particiapnts in a group
                                var dictParticipantsInfo = [String : Any]()
                                dictParticipantsInfo["newsletter"] = participant.isNewsletterSubscribe
                                dictParticipantsInfo["age"] = participant.age
                                dictParticipantsInfo["gender"] = participant.gender
                                dictParticipantsInfo["businessname"] = group.businessname
                                dictParticipantsInfo["mimetype"] = "image/jpeg"
                                dictParticipantsInfo["groupname"] = group.groupName
                                dictParticipantsInfo["name"] = participant.name
                                dictParticipantsInfo["email"] = participant.email
                                dictParticipantsInfo["phoneno"] = participant.phoneNo
                                dictParticipantsInfo["filecontent"] = participant.signaturefileContent
                                dictParticipantsInfo["filename"] = "signature.jpg"
                                arrGroupParicipants.append(dictParticipantsInfo)
                                
                                print(dictParticipantsInfo)
                            }
                            dictGroupInfo["GroupParticipantsInfo"] = arrGroupParicipants
                        }
                    }
                    arrGroupInfo.append(dictGroupInfo)
                }
            }
            
        }
        
        if(arrGroupInfo.count == 0)
        {
            handler(true, "Data already Synced")
            return
        }
        
        groupInfo["groupInfo"] = arrGroupInfo
        dictData["data"] = groupInfo
        
        print(dictData)
        
        if(isNetAvailable())
        {
          ModelManager.sharedInstance.waverManager.synchDataOnServer(synchData: dictData) { (isSuccess, strMsg) in
                
                //SVProgressHUD.dismiss()
                
                if(isSuccess)
                {
                    arrGroupInfo.removeAll()
                    ModelManager.sharedInstance.waverManager.deleteAllDataFromDB()
                    handler(true, "Data has been Synced Successfully")
                    
                }
                else
                {
                    handler(false, "\(strMsg)")
                }
            }
        }
        else
        {
            handler(false, "Please connect with internet")
        }
    }
    
    // MARK: - Internet Available
    func isNetAvailable() -> Bool {
        let reach = Reachability()
        if let reachable : String = reach?.currentReachabilityString
        {
            if(reachable != "No Connection")
            {
                return true
            }
        }
        return false
    }
    
    
    
}
