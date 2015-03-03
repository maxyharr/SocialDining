//
//  LoginViewController.swift
//  SocialDining
//
//  Created by Maximilian Harris on 3/3/15.
//  Copyright (c) 2015 UCB Systems. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet var fbLoginView : FBLoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    
    // FACEBOOK DELEGATE METHODS
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("user logged in")
        println("This is where you perform the segue")
        performSegueWithIdentifier("loggedInSegue", sender: self)
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("user name: \(user.name)")
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("user logged out")
    }
    
    func loginView(loginView : FBLoginView!, handleError : NSError) {
        println("error: \(handleError.localizedDescription)")
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
