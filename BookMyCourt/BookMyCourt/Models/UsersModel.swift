//
//  UserModel.swift
//  BookMyCourt
//
//  Created by student on 3/9/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import Parse
class Users:PFObject, PFSubclassing {
    @NSManaged var User_ID:Int
    @NSManaged var PhoneNumber:String
    @NSManaged var Bookings:String
    @NSManaged var Court:String
    @NSManaged var AvailabilityID:String
    
    static func parseClassName() -> String {
        return "Users"
    }
//    init(User_ID:Int,PhoneNumber:String,Bookings:String) {
//        self.User_ID = User_ID
//        self.PhoneNumber = PhoneNumber
//        self.Bookings = Bookings
//    }
}

