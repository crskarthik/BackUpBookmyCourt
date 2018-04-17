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
    var users:[User]
    var courts:[Court]
    var availabilities:[Availability]
    var timeslots:[TimeSlot]
    var bookings:[Booking]
    init() {
        users=[]
        courts=[]
        availabilities=[]
        timeslots=[]
        bookings=[]
    }
    func loadAvailabilityData(){
        let query = PFQuery(className:"Availability")
        query.findObjectsInBackground {(objects: [PFObject]?, error: Error?) -> Void
            in
            if error == nil
            {
                for availability in objects!{
                    var newcourt:Court=Court()
                    var newtimeslot:TimeSlot=TimeSlot()
                    var date:Date = availability["DateID"] as! Date
                    var isAvailable:Bool = (availability["isAvailable"] != nil)
                    var objID:PFObject=availability["Court"] as! PFObject
                    let query1 = PFQuery(className:"Court")
                    query1.whereKey("objectId", equalTo: objID)
                    query1.getObjectInBackground(withId: <#T##String#>)
                    query1.findObjectsInBackground {(objects: [PFObject]?, error: Error?) -> Void
                        in
                        if error == nil
                        {
                            for court in objects!{
                                newcourt=Court(courtID: court["CourtID"] as! Int,CourtLocation: court["CourtLocation"] as! String)
                            }
                        }
                        else { // Log details of the failure
                            
                        }
                        var objID1:String=availability["TimeSlot"] as! String
                        let query2 = PFQuery(className:"TimeSlot")
                        query2.whereKey("objectId", equalTo: objID1)
                        query2.findObjectsInBackground {(objects: [PFObject]?, error: Error?) -> Void
                            in
                            if error == nil
                            {
                                for timeslot in objects!{
                                    newtimeslot=TimeSlot(timeslot: timeslot["TimeSlotID"] as! Int,timing: timeslot["Timing"] as! String)
                                }
                            }
                            else { // Log details of the failure
                                
                            }
                            self.availabilities.append(Availability(dateID: date,timeSlot: newtimeslot,court: newcourt,isAvailable: isAvailable))
                        }
                        
                        
                    }
                    
                }
                print(self.availabilities)
                
            }
        }
    }
}
