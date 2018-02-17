//
//  FirstViewController.swift
//  BookMyCourt
//
//  Created by Student on 2/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class AvailabilityViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let days = ["DAYS","Monday","Tuesday","Wednesday","Thrusday","Friday","Saturday","Sunday"]
    let availablity = ["STATUS","Available","Not Available","Available","Not Available","Available","Not Available","Available"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availabilityList")!
        cell.textLabel?.text = days[indexPath.row]
        cell.detailTextLabel?.text = availablity[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

