//
//  Groups+CoreDataProperties.swift
//  DigitalWaiver
//
//  Created by Kabir Chandoke on 11/27/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//
//

import Foundation
import CoreData


extension Groups {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Groups> {
        return NSFetchRequest<Groups>(entityName: "Groups")
    }

    @NSManaged public var buisness: String?
    @NSManaged public var groupname: String?
    @NSManaged public var issynched: Bool
    @NSManaged public var participantsno: String?
    @NSManaged public var waverlink: String?
    @NSManaged public var groupToParticipentRelation: NSSet?

}

// MARK: Generated accessors for groupToParticipentRelation
extension Groups {

    @objc(addGroupToParticipentRelationObject:)
    @NSManaged public func addToGroupToParticipentRelation(_ value: Participants)

    @objc(removeGroupToParticipentRelationObject:)
    @NSManaged public func removeFromGroupToParticipentRelation(_ value: Participants)

    @objc(addGroupToParticipentRelation:)
    @NSManaged public func addToGroupToParticipentRelation(_ values: NSSet)

    @objc(removeGroupToParticipentRelation:)
    @NSManaged public func removeFromGroupToParticipentRelation(_ values: NSSet)

}
