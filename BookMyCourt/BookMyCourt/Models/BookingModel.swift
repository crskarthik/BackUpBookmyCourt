//
//  BookingModel.swift
//  BookMyCourt
//
//  Created by student on 3/9/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Booking{
    var bookingId:Int
    var dateID:Date
    var timeslot:TimeSlot
    var court:Court
    
    init(bookingID:Int,dateID:Date,timeslot:TimeSlot,court:Court) {
        self.bookingId = bookingID
        self.dateID = dateID
        self.timeslot = timeslot
        self.court = court
    }
}
