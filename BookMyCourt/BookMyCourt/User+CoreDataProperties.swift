//
//  User+CoreDataProperties.swift
//  BookMyCourt
//
//  Created by Vallamsetty,Revanth on 4/22/18.
//  Copyright © 2018 Student. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var user_ID: Int16
    @NSManaged public var phoneNumber: String?

}
