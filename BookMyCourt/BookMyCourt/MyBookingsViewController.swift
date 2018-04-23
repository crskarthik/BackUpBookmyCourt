//
//  MyBookingsViewController.swift
//  BookMyCourt
//
//  Created by Vallamsetty,Revanth on 2/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import Parse
import CoreData
class MyBookingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var bookings:[String] = ["Date 03/15/2018 14:30 Right court","Date 04/12/2018 13:30 Left court","Date 05/15/2018 9:30 Centre court"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var theControllers = [UIViewController]()
        theControllers.append(self.navigationController!.viewControllers.first!)
        theControllers.append(self.navigationController!.viewControllers.last!)
        self.navigationController?.setViewControllers(theControllers, animated: false)
        self.title="View Bookings"
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "bookSuccess"), object: nil)
        AppDelegate.dfetch.loadUserData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        let fetchRequest:NSFetchRequest<CoreUser> = CoreUser.fetchRequest()
        do{
            let users = try AppDelegate.context.fetch(fetchRequest)
            if users != nil && users != []{
                self.Txt919TF.text=String(users[0].user_ID)
                self.TxtPNTF.text=users[0].phoneNumber
            }
        }
        catch{
            
        }
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var Txt919TF: UITextField!
    @IBOutlet weak var TxtPNTF: UITextField!
    @IBOutlet weak var userBookingsTV: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "bookSuccess"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "delete"), object: nil)
        if(AppDelegate.userPN != "" && AppDelegate.userPN.count == 10 && String(AppDelegate.user919).count == 9){
            TxtPNTF.text=AppDelegate.userPN
            Txt919TF.text=String(AppDelegate.user919)
            
        }else{
            TxtPNTF.text=""
            Txt919TF.text=""
            print("Inside Else")
        }
        AppDelegate.dfetch.loadUserData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        //            self.userBookingsTV.reloadData()
    }
    @objc func loadList(){
        //load data here
        self.userBookingsTV.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "delete"), object: nil)
        return AppDelegate.dfetch.getUserData().count
    }
    
    
    //    @IBOutlet weak var CellDataTvLBL: UILabel!
    //    @IBOutlet weak var CellTimeTvLBL: UILabel!
    //    @IBOutlet weak var CellCourtLocationTvLBL: UIImageView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Booking")
        //        print(type(of: cell?.viewWithTag(0)))
        let CellDataTvLBL=cell?.viewWithTag(100) as! UILabel
        let CellTimeTvLBL = cell?.viewWithTag(101) as! UILabel
        let CellCourtLocationTvLBL = cell?.viewWithTag(102) as! UIImageView
        print(AppDelegate.dfetch.getUserData()[indexPath.row].Bookings)
        CellDataTvLBL.text = String(AppDelegate.dfetch.getUserData()[indexPath.row].Bookings.split(separator: " ")[0])
        CellTimeTvLBL.text = String(AppDelegate.dfetch.getUserData()[indexPath.row].Bookings.split(separator: " ")[1])
        
        switch(AppDelegate.dfetch.getUserData()[indexPath.row].Court){
        case "Left":
            CellCourtLocationTvLBL.image = AppDelegate.courtImages[0]
        case "Center":
            CellCourtLocationTvLBL.image = AppDelegate.courtImages[1]
        case "Right":
            CellCourtLocationTvLBL.image = AppDelegate.courtImages[2]
        default:
            CellCourtLocationTvLBL.image = nil
        }
        if indexPath.row == AppDelegate.dfetch.getUserData().count{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
        }
        if(indexPath.row % 2 == 0){
            cell?.backgroundColor = UIColor.darkGray
        }
        else{
            cell?.backgroundColor = UIColor.lightGray
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            AppDelegate.selectedBooking = AppDelegate.dfetch.users[indexPath.row].Bookings
            AppDelegate.dfetch.users[indexPath.row].deleteInBackground(block:  {(success,error) in
                
                if(error==nil){
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "delete"), object: nil)
                    self.userBookingsTV.reloadData()
                    self.ViewBookingsBTNAction(UIButton.self)
                    var que1:PFQuery = PFQuery(className: "Availability")
                    var cou=AppDelegate.dfetch.users[indexPath.row].Court
                    print()
                    que1.whereKey("objectId", equalTo: AppDelegate.dfetch.users[indexPath.row].AvailabilityID)
                    que1.findObjectsInBackground(block: { (Objects: [PFObject]?, error:Error?) in
                        for obj in Objects!{
                           obj["IsAvailable"]=true
                            obj.saveInBackground(block: { (success, error) -> Void in
                             
                           })
                        }
                    })
                    
                    
                }
            })
            
            self.displayOKAlert(title: "Success!",message:"Delete successful")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "delete"), object: nil)
            self.userBookingsTV.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "delete"), object: nil)
        AppDelegate.dfetch.loadUserData()
        
    }
    
    @IBAction func ViewBookingsBTNAction(_ sender: Any) {
        if(Txt919TF.text!.count>0&&TxtPNTF.text!.count>0){
            let T919Num = Txt919TF.text!
            let TxtPN = TxtPNTF.text!
            if(T919Num.prefix(3) != "919" || T919Num.count != 9){
                self.displayOKAlert(title: "Error!", message:"Invalid 919 Number")
            }
            else if(TxtPN.count != 10){
                self.displayOKAlert(title: "Error!", message:"Invalid Phone Number")
            }
            else{
                AppDelegate.user919 = Int(Txt919TF.text!)!
                AppDelegate.userPN = TxtPNTF.text!
                AppDelegate.dfetch.loadUserData()
                print("Passed user data into view controller \(AppDelegate.dfetch.getUserData().count)")
                self.userBookingsTV.reloadData()
            }
        }else{
            self.displayOKAlert(title: "Error!", message:"Please enter all the fields to view reservations!")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "delete"), object: nil)
        
    }
    func displayOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
