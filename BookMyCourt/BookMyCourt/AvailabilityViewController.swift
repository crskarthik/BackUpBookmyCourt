//
//  FirstViewController.swift
//  BookMyCourt
//
//  Created by Student on 2/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import Parse

class AvailabilityViewController:  UIViewController,UITableViewDataSource,UITableViewDelegate {
    let days = ["DAYS","Monday","Tuesday","Wednesday","Thrusday","Friday","Saturday","Sunday"]
    let availablity = ["STATUS","Available","Not Available","Available","Not Available","Available","Not Available","Available"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Inside")
        let cell = tableView.dequeueReusableCell(withIdentifier: "availabilityList")!
               print(courts.count)
        cell.textLabel?.text = "\(courts[indexPath.row].courtID)"
        cell.detailTextLabel?.text = courts[indexPath.row].CourtLocation

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let query = PFQuery(className:"Court")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil
            {
                for i in 0..<objects!.count{
                    self.courts.append(Court(courtID: objects![i]["CourtID"] as! Int, CourtLocation: objects![i]["CourtLocation"] as! String))
                }
                
                //                print(self.courts[0].CourtLocation+"-------")
                self.courtsAvailabilityTV.reloadData()
            }
            else {
                // Log details of the failure
                print("Oops \(error!)")
                
            }
            
        }
    }
    @IBOutlet weak var courtsAvailabilityTV: UITableView!
    
    var courts:[Court] = [];
    var court:Court = Court();
    override func viewWillAppear(_ animated: Bool) {
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

