//
//  DataFetch.swift
//  BookMyCourt
//
//  Created by Vallamsetty,Revanth on 4/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
import Parse
class DataFetch{
    var users:[Users]
    var availabilities:[Availability]
    var temp:[Availability]=[]
    init() {
        users=[]
        availabilities=[]
    }
    func loadAvailabilityData(SelectedDate date:String){
        let query=PFQuery(className:"Availability")
        query.whereKey("IsAvailable", equalTo: true)
        query.whereKey("Date", equalTo:date)
        query.findObjectsInBackground {(objects: [PFObject]?, error: Error?)-> Void in
            if(error == nil){
            self.availabilities=objects as! [Availability]
            print("Inside Data Fetch \(self.availabilities.count)")
            print("Date:\(date)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                
            }else{
                print(error!)
            }
        }
        }
    func loadUserData(){
        let query=PFQuery(className:"Users")
        query.whereKey("User_ID", equalTo:AppDelegate.user919)
        query.whereKey("PhoneNumber", equalTo:AppDelegate.userPN)
        query.findObjectsInBackground {(objects: [PFObject]?, error: Error?)-> Void in
            self.users=objects as! [Users]
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    

    func getUserData() -> [Users] {
        return users
    }
    func getAvailabilities() -> [Availability] {
        return availabilities
    }
}

