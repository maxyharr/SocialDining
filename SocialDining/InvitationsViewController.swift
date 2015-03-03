//
//  InvitationsViewController.swift
//  SocialDining
//
//  Created by Maximilian Harris on 3/1/15.
//  Copyright (c) 2015 UCB Systems. All rights reserved.
//

import UIKit

class InvitationsViewController: UIViewController, UITableViewDataSource {

    var arr = [Invitation]()
    var refreshControl:UIRefreshControl!
    var lastUpdateString = "never"
    
    @IBOutlet weak var invitationsTableView: UITableView!
        
    @IBAction func facebookAction(sender: AnyObject) { }
    
    @IBAction func shareInvitations(sender: AnyObject) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize the refresh control.
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last update: " + lastUpdateString)
        self.refreshControl.backgroundColor = UIColor.lightGrayColor()
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.invitationsTableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject)
    {
        // Code to refresh table view
        if (self.refreshControl != nil) {
            var format = NSDateFormatter()
            // Format broken, time zone issue
            format.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
            
            var newInvitation1 = Invitation(title: "Breakfast", restaurant: "Village Coffee Shop", creator: "Max Harris", time: format.dateFromString("2015-03-02 17:00:34 +0000")!)
            var newInvitation2 = Invitation(title: "Lunch", restaurant: "Fate Brewery", creator: "Jeff Fordham", time: format.dateFromString("2015-03-02 19:00:40 +0000")!)
            var newInvitation3 = Invitation(title:  "Dinner", restaurant: "Cheesecake Factory", creator: "Steve Jackson", time: format.dateFromString("2015-03-03 00:00:27 +0000")!)
            
            arr = [newInvitation1, newInvitation2, newInvitation3]
            
            var refreshFormat = NSDateFormatter()
            refreshFormat.dateFormat = "MMM d, h:mm a"
            let dateString = refreshFormat.stringFromDate(NSDate())
            lastUpdateString = "Last update: \(dateString)"
            self.refreshControl.attributedTitle = NSAttributedString(string: lastUpdateString)
            self.refreshControl.endRefreshing()
            invitationsTableView.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (arr.count > 1) {
            self.invitationsTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine;
            self.invitationsTableView.backgroundView = nil;
            return 1
        }
        
        else {
            // Display a message when the table is empty
            var messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height));
            messageLabel.text = "No invitations. Please pull down to refresh or create an invitation"
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.sizeToFit()
        
            self.invitationsTableView.backgroundView = messageLabel
            self.invitationsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("invitationCell", forIndexPath: indexPath) as InvitationCell
        let inv = self.arr[indexPath.row]
        cell.titleLabel.text = inv.title
        cell.restaurantLabel.text = inv.restaurant
        cell.creatorLabel.text = inv.creator
        
        let dateFormat = NSDateFormatter()
        let timeFormat = NSDateFormatter()
        dateFormat.dateFormat = "EEEE, MMMM d"
        timeFormat.timeStyle = NSDateFormatterStyle.ShortStyle
        
        let dateString = dateFormat.stringFromDate(inv.time)
        let timeString = timeFormat.stringFromDate(inv.time)
        
        cell.dateLabel.text = dateString
        cell.timeLabel.text = timeString
        return cell
    }

    // ROW SHOULDN'T REMAIN SELECTED
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

