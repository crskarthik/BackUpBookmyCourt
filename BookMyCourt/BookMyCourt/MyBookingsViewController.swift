//
//  MyBookingsViewController.swift
//  BookMyCourt
//
//  Created by Vallamsetty,Revanth on 2/16/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class MyBookingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var bookings:[String] = ["Date 03/15/2018 14:30 Full court","Date 04/12/2018 13:30 Half court","Date 05/15/2018 9:30 Full court"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Booking")
        cell?.textLabel?.text = bookings[indexPath.row]
        return cell!
        
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
