//
//  CourtModel.swift
//  BookMyCourt
//
//  Created by student on 3/9/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Court{
    var courtID:Int
    var courtLocation:String
    
    init(courtID:Int,courtLocation:String) {
        self.courtID = courtID
        self.courtLocation = courtLocation
    }
}
