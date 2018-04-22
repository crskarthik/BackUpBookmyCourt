//
//  AvailabilityModel.swift
//  BookMyCourt
//
//  Created by student on 3/9/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import Parse
class  Availability:PFObject, PFSubclassing{
    @NSManaged var Availability_Key:String
    @NSManaged var Availability_ID:Int
    @NSManaged var Timeslot:String
    @NSManaged var IsAvailable:Bool
    @NSManaged var Court:String
    @NSManaged var AvailabilityDateTime:String
    
    static func parseClassName() -> String {
        return "Availability"
    }
}


