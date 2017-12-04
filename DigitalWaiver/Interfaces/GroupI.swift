//
//  GroupI.swift
//  DigitalWaiver
//
//  Created by Abhishek Singla on 04/12/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class GroupI: NSObject {
    //setter and getters
    public var groupName: String?
    public var participantNo : String?
    public var link: String?
    public var businessname: String?
    public var isNewGroup: Bool?

    
    override init() {
        
        self.groupName = ""
        self.participantNo = ""
        self.link = ""
        self.businessname = ""
        self.isNewGroup = false
    }
    
    func resetData()
    {
        self.groupName = ""
        self.participantNo = ""
        self.link = ""
        self.businessname = ""
        self.isNewGroup = false
    }
}
