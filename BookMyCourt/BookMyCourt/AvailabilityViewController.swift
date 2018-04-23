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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Inside table view\(AppDelegate.dfetch.getAvailabilities().count)")
        return AppDelegate.dfetch.getAvailabilities().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "availabilityList")!
        cell.textLabel?.text=AppDelegate.dfetch.getAvailabilities()[indexPath.row].Timeslot
        cell.detailTextLabel?.text=AppDelegate.dfetch.getAvailabilities()[indexPath.row].Court
        if indexPath.row == AppDelegate.dfetch.getAvailabilities().count{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        if(indexPath.row % 2 == 0){
            cell.backgroundColor = UIColor.gray
        }
        else{
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppDelegate.userSelectedAvailability=indexPath.row
        AppDelegate.selectedSlotAvailabilityKey = AppDelegate.dfetch.getAvailabilities()[indexPath.row].objectId!
        AppDelegate.selectedCourt = AppDelegate.dfetch.getAvailabilities()[indexPath.row].Court
        AppDelegate.selectedDate = AppDelegate.dfetch.getAvailabilities()[indexPath.row].Date
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.courtsAvailabilityTV.setNeedsDisplay()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AvailableDatePicketBTN.minimumDate=Date()
        AvailableDatePicketBTN.maximumDate=Date().addingTimeInterval(604800)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        AppDelegate.dfetch.loadAvailabilityData(SelectedDate:  dateFormatter.string(from: Date()))
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        self.courtsAvailabilityTV.reloadData()
        self.courtsAvailabilityTV.setNeedsDisplay()
        print("View Did Load")
        
    }
    @IBOutlet weak var courtsAvailabilityTV: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.dfetch.loadAvailabilityData(SelectedDate:  AppDelegate.selectedDate)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        self.courtsAvailabilityTV.reloadData()
        self.courtsAvailabilityTV.setNeedsDisplay()
        self.btnAction(UIButton.self)
        print("View Will appear\(AppDelegate.dfetch.getAvailabilities().count)")
        
    }
    
    @IBOutlet weak var Button: UIButton!
    
    @IBAction func btnAction(_ sender: Any) {
        courtsAvailabilityTV.isHidden=false
        AppDelegate.dfetch.loadAvailabilityData(SelectedDate: AppDelegate.selectedDate)
        self.courtsAvailabilityTV.reloadData()
    }
    
    @IBOutlet weak var AvailableDatePicketBTN: UIDatePicker!
    
    @IBAction func AvailabilitySelectionAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        AppDelegate.selectedDate = dateFormatter.string(from: AvailableDatePicketBTN.date)
        AppDelegate.dfetch.loadAvailabilityData(SelectedDate: AppDelegate.selectedDate)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        DispatchQueue.main.async {
            self.courtsAvailabilityTV.reloadData()
        }
        self.courtsAvailabilityTV.setNeedsDisplay()
    }
    @objc func loadList(){
        //load data here
        self.courtsAvailabilityTV.reloadData()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

