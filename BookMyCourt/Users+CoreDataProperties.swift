//
//  Users+CoreDataProperties.swift
//  BookMyCourt
//
//  Created by Vallamsetty,Revanth on 4/22/18.
//  Copyright © 2018 Student. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var user_ID: Int16
    @NSManaged public var phoneNumber: String?

}
