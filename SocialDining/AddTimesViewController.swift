//
//  AddTimesViewController.swift
//  SocialDining
//
//  Created by Maximilian Harris on 3/1/15.
//  Copyright (c) 2015 UCB Systems. All rights reserved.
//

import UIKit

protocol AddTimesDelegate {
    func updateNewTime(data: NSDate)
}

class AddTimesViewController: UIViewController {
    var delegate: AddTimesDelegate?
    
    @IBOutlet weak var dateTime: UIDatePicker!
    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func finish(sender: AnyObject) {
        self.delegate?.updateNewTime(self.dateTime.date)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
