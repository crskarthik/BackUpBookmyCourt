//
//  BookingModel.swift
//  BookMyCourt
//
//  Created by Vallamsetty,Revanth on 4/2/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
class Booking
{
    var bookingID:Int
    var dateID:Date
    var timeSlot:TimeSlot
    var court:Court

    init(bookingID:Int,dateID:Date,timeSlot:TimeSlot,court:Court) {
     self.bookingID=bookingID
     self.dateID=dateID
     self.timeSlot=timeSlot
      self.court=court
    }
}
