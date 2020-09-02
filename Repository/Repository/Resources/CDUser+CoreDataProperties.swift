//
//  CDUser+CoreDataProperties.swift
//  Repository
//
//  Created by alpiopio on 01/09/20.
//  Copyright © 2020 alfian0. All rights reserved.
//
//

import Foundation
import CoreData

extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var profile: String?
    @NSManaged public var birthDate: Date?
    @NSManaged public var gender: String?

}
