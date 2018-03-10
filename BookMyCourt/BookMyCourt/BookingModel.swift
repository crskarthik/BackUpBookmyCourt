//
//  BookingModel.swift
//  BookMyCourt
//
//  Created by Vallamsetty,Revanth on 3/9/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
class BookingModel{
    var today:Date
    var Week:[Date]=[]
    var timings:[String]=[]
    init()
    {
        today = Date.init()
        Week.append(today)
        loadWeek()
    }
    func loadWeek()
    {
        for i in 0..<6{
            Week.append(Week[i].addingTimeInterval(86400))
        }
    }
    func giveTimings(selectedDate:Date)
    {
        
    }
}
