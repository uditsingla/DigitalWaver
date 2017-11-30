//
//  Participants+CoreDataProperties.swift
//  DigitalWaiver
//
//  Created by Kabir Chandoke on 11/30/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//
//

import Foundation
import CoreData


extension Participants {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Participants> {
        return NSFetchRequest<Participants>(entityName: "Participants")
    }

    @NSManaged public var age: String?
    @NSManaged public var businessname: String?
    @NSManaged public var email: String?
    @NSManaged public var filecontent: String?
    @NSManaged public var filename: String?
    @NSManaged public var gender: String?
    @NSManaged public var groupname: String?
    @NSManaged public var issynched: Bool
    @NSManaged public var mimetype: String?
    @NSManaged public var name: String?
    @NSManaged public var newsletter: Bool
    @NSManaged public var participantsNo: String?
    @NSManaged public var phoneno: String?
    @NSManaged public var participentToGroupRelation: Groups?

}
