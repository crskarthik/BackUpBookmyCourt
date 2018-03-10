//
//  UserModel.swift
//  BookMyCourt
//
//  Created by student on 3/9/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class User {
    var studentID:String
    var phoneNumber:String
    var rememberMe:Bool
    var booking:Booking
    
    init(studentID:String,phoneNumber:String,rememberMe:Bool,booking:Booking) {
        self.studentID = studentID
        self.phoneNumber = phoneNumber
        self.rememberMe = rememberMe
        self.booking = booking
    }
}
