//
//  AvailabilityModel.swift
//  BookMyCourt
//
//  Created by student on 3/9/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class  Availability{
    var dateID:Date
    var timeSlot:TimeSlot
    var courtID:Int
    var isAvailable:Bool
    
    init(dateID:Date,timeSlot:TimeSlot,courtID:Int,isAvailable:Bool) {
        self.dateID = dateID
        self.timeSlot = timeSlot
        self.courtID = courtID
        self.isAvailable = isAvailable
    }
}
