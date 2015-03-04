//
//  SecondViewController.swift
//  SocialDining
//
//  Created by Maximilian Harris on 3/1/15.
//  Copyright (c) 2015 UCB Systems. All rights reserved.
//

import UIKit

class CreateInvitationViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, AddTimesDelegate {

    var restaurantsAdded:[String] = []
    var timesAdded:[NSDate] = []
    var friendsAdded:[String] = []
    
    @IBOutlet weak var createInvitationTableView: UITableView!
    
    
    @IBAction func submitInvitation(sender: AnyObject) {
        // implement actual code to update invitations database
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    
    // DETERMINE NUMBER OF CELLS IN EACH SECTION
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // Title section
        if (section == 0) { return 1 } // only 1 invitation title
        
        // Return +1 for the "Add" row
    
        // Restaurants section
        else if (section == 1) { return restaurantsAdded.count + 1 }
        
        // Times section
        else if (section == 2) { return timesAdded.count + 1 }
        
        // Friends section
        else { return friendsAdded.count + 1 }
    }
    
    
    // DEFINE WHAT KIND OF CELL AT EACH POSITION
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell();
        
        if (indexPath.section == 0) { // Title section
            cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath) as UITableViewCell
        }
        
        else if (indexPath.section == 1) { // Restaurants section
            
            if (indexPath.row < restaurantsAdded.count) {
                cell = tableView.dequeueReusableCellWithIdentifier("restaurantCell", forIndexPath: indexPath) as UITableViewCell
            }
            
            else { cell = tableView.dequeueReusableCellWithIdentifier("addRestaurantsCell", forIndexPath: indexPath) as UITableViewCell }
            
        }
        
        else if (indexPath.section == 2) { // Times section
            if (indexPath.row < timesAdded.count) {
                cell = tableView.dequeueReusableCellWithIdentifier("timeCell", forIndexPath: indexPath) as UITableViewCell
                var dateFormat = NSDateFormatter()
                dateFormat.dateFormat = "EEEE, MMMM d 'at' h:mm a"
                let dateString = dateFormat.stringFromDate(timesAdded[indexPath.row])
                cell.textLabel?.text = dateString
            }
            
            else { cell = tableView.dequeueReusableCellWithIdentifier("addTimesCell", forIndexPath: indexPath) as UITableViewCell }
            
        }
        
        else { // Friends section
            if (indexPath.row < friendsAdded.count) {
                cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath) as UITableViewCell
            }
            
            else { cell = tableView.dequeueReusableCellWithIdentifier("addFriendsCell", forIndexPath: indexPath) as UITableViewCell }
            
        }
        
        return cell
    }
    
    // ALLOW CERTAIN ROWS TO BE DELETED
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if (indexPath.section == 1) { // Restaurants section
            if (indexPath.row < restaurantsAdded.count) { return true }
        }
        
        else if (indexPath.section == 2) { // Times section
            if (indexPath.row < timesAdded.count) { return true }
        }
        
        else if (indexPath.section == 3) { // Friends section
            if (indexPath.row < friendsAdded.count) { return true }
        }
        
        return false
    }
    
    // DELETING ROWS
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 1) {
            restaurantsAdded.removeAtIndex(indexPath.row)
        }
        
        else if (indexPath.section == 2) {
            timesAdded.removeAtIndex(indexPath.row)
        }
        
        else if (indexPath.section == 3) {
            friendsAdded.removeAtIndex(indexPath.row)
        }
        
        createInvitationTableView.reloadData()
    }
    
    // ROW SHOULDN'T REMAIN SELECTED
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // DONE BUTTON IN KEYBOARD SHOULD CLOSE KEYBOARD
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // DEALING WITH SEGUES TO OTHER VIEW CONTROLLERS (MODALS)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addTimeSegue") {
            let destCont = segue.destinationViewController as? AddTimesViewController
            destCont?.delegate = self
        }
    }
    
    // GRAB DATA FROM UNWINDING SEGUE'S DELEGATE METHOD
    func updateNewTime(data: NSDate) {
        if (contains(timesAdded, data) == false) {
            println(data)
            timesAdded.append(data)
            createInvitationTableView.reloadData()
        }
    }

}

