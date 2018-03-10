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
        return AppDelegate.model.Week.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availabilityList")!
        cell.textLabel?.text = AppDelegate.model.Week[indexPath.row].description
        cell.detailTextLabel?.text = availablity[indexPath.row]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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

