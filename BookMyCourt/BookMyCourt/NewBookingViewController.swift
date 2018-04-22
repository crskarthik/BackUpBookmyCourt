//
//  SecondViewController.swift
//  BookMyCourt
//
//  Created by Student on 2/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import Parse
import EventKit
import UserNotifications

class NewBookingViewController: UIViewController {
    
    @IBOutlet weak var Txt919Number: UITextField!
    @IBOutlet weak var TxtPhoneNumber: UITextField!
    @IBOutlet weak var LblMessage: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var selectedSlot: UILabel!
    @IBOutlet weak var locationLBL: UILabel!
    var savedEventId : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="New Booking"
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error != nil {
                print("Authorization Unsuccessfull")
            }else {
                print("Authorization Successfull")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedSlot.text=AppDelegate.dfetch.getAvailabilities()[AppDelegate.userSelectedAvailability].Timeslot
        dateLabel.text = AppDelegate.selectedDate
        courtLocation.text = AppDelegate.selectedCourt
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var segueFlag:Bool=true
        let T919Num = Txt919Number.text!
        let TxtPN = TxtPhoneNumber.text!
        if(identifier=="BookSuccess"){
            if(Txt919Number.text!.count>0&&TxtPhoneNumber.text!.count>0){
                AppDelegate.user919=Int(T919Num)!
                AppDelegate.userPN=TxtPN
                if(T919Num.prefix(3) != "919" || T919Num.count != 9){
                    self.displayOKAlert(title: "Error!", message:"Invalid 919 Number")
                }
                else if(TxtPN.count != 10){
                    self.displayOKAlert(title: "Error!", message:"Invalid Phone Number")
                }
                else{
                    let userdata = PFObject(className: "Users")
                    userdata["User_ID"]=Int(Txt919Number.text!)!
                    userdata["PhoneNumber"]=TxtPhoneNumber.text
                    userdata["Bookings"]=AppDelegate.selectedDate+" "+selectedSlot.text!
                    userdata["Court"]=AppDelegate.selectedCourt
                    userdata.saveInBackground(block: { (success, error) -> Void in
                        if success{
                            let updateQuery = PFQuery(className: "Availability")
                            updateQuery.getObjectInBackground(withId: AppDelegate.selectedSlotAvailabilityKey) { (object, error) -> Void in
                                if object != nil && error == nil{
                                    object!["IsAvailable"]=false
                                    object!.saveInBackground()
                                    self.displayOKAlert(title: "Success!", message:"Slot booked successfully on \n court: \(AppDelegate.selectedCourt) Time:  \(self.selectedSlot.text!) \n Date: \(AppDelegate.selectedDate)")
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "bookSuccess"), object: nil)
                                    
                                    self.timedNotifications(inSeconds: 15) { (success) in
                                        if success {
                                            print("Successfully Notified")
                                        }
                                    }
                                    
                                    let eventStore = EKEventStore()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "MM/dd/yyyy HH:mm" //Your date format
                                    //dateFormatter.timeZone = TimeZone(abbreviation: "CST+0:00") //Current time zone
                                    let timeString = self.selectedSlot.text!.components(separatedBy: "-")
                                    let date = dateFormatter.date(from: AppDelegate.selectedDate+" "+timeString[0])
                                    let startDate = date! as NSDate
                                    let endDate = startDate.addingTimeInterval(30 * 60) // One hour
                                    
                                    if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
                                        eventStore.requestAccess(to: .event, completion: {
                                            granted, error in
                                            self.createEvent(eventStore: eventStore, title: "Basketball Game", startDate: startDate, endDate: endDate)
                                        })
                                    } else {
                                        self.createEvent(eventStore: eventStore, title: "BasketBall Game", startDate: startDate, endDate: endDate)
                                    }
                                }
                                else{
                                    print("Unable to update availability")
                                    print(error!)
                                    AppDelegate.user919=0
                                    AppDelegate.userPN=""
                                    segueFlag=false
                                }
                            }
                            
                        }
                        else{
                            print("Error")
                            AppDelegate.user919=0
                            AppDelegate.userPN=""
                            segueFlag=false
                        }
                    })
                }
            }else{
                AppDelegate.user919=0
                AppDelegate.userPN=""
                self.displayOKAlert(title: "Error!", message:"Please enter all the fields to book the slot!")
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "bookSuccess"), object: nil)
        return segueFlag
    }
    
    @objc func loadList(){
        //load data here
        AppDelegate.user919=Int(Txt919Number.text!)!
        AppDelegate.userPN=TxtPhoneNumber.text!
    }
    
    @IBOutlet weak var courtLocation: UILabel!
    
    func displayOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        AppDelegate.user919=Int(Txt919Number.text!)!
        AppDelegate.userPN=TxtPhoneNumber.text!
        self.present(alert, animated: true)
    }
    
    // Creates an event in the EKEventStore. The method assumes the eventStore is created and
    // accessible
    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate as Date!
        event.endDate = endDate as Date!
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.save(event, span: .thisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened")
        }
    }
    
    // Removes an event from the EKEventStore. The method assumes the eventStore is created and
    // accessible
    func deleteEvent(eventStore: EKEventStore, eventIdentifier: String) {
        let eventToRemove = eventStore.event(withIdentifier: eventIdentifier)
        if (eventToRemove != nil) {
            do {
                try eventStore.remove(eventToRemove!, span: .thisEvent)
            } catch {
                print("Bad things happened")
            }
        }
    }
    
    func timedNotifications(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "BookMyCourt"
        content.subtitle = "Reservation Successfull"
        content.body = "Slot booked successfully on  court: \(AppDelegate.selectedCourt) \n Time:  \(self.selectedSlot.text!) ; Date: \(AppDelegate.selectedDate)"
        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                completion(false)
            }else {
                print("completed success")
                completion(true)
            }
        }
    }
    
}

