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
    var court:Court
    var isAvailable:Bool
    
    init(dateID:Date,timeSlot:TimeSlot,court:Court,isAvailable:Bool) {
        self.dateID = dateID
        self.timeSlot = timeSlot
        self.court = court
        self.isAvailable = isAvailable
    }
}
