//
//  TimeSlotModel.swift
//  BookMyCourt
//
//  Created by student on 3/9/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class TimeSlot {
    var timeSlotID:Int
    var timing:String
    
    init(timeslot:Int,timing:String) {
        self.timeSlotID = timeslot
        self.timing = timing
    }
}
