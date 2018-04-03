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
    var CourtLocation:String
    
    init(courtID:Int,CourtLocation:String) {
        self.courtID = courtID
        self.CourtLocation = CourtLocation
    }
    init() {
        self.courtID = 0
        self.CourtLocation = ""
    }

        static func parseClassName() -> String
        {
        return "Court"
        
        }

}
