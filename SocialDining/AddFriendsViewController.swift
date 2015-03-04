//
//  AddFriendsViewController.swift
//  SocialDining
//
//  Created by Maximilian Harris on 3/3/15.
//  Copyright (c) 2015 UCB Systems. All rights reserved.
//

import UIKit

class AddFriendsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var facebookFriendsCollectionView: UICollectionView!
    
    @IBAction func friendSelected(sender: AnyObject) {
        println("friend selected")
    }
    
    var facebookFriends = [FacebookFriend]()
    
    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFacebookFriends()
    }
    
    // WHEN THE PAGE LOADS, PULL IN FACEBOOK FRIENDS, STORE AS FRIEND OBJECTS IN ARRAY USED TO POPULATE COLLECTION
    func fetchFacebookFriends() {
        var friendsRequest = FBRequest.requestForMyFriends() //FBRequest(forGraphPath: "/me/friends")
        friendsRequest.startWithCompletionHandler{ (connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            var first_name:String
            var last_name:String
            var name:String
            var id:String
            var profilePictureURL:NSURL
            
            if (error == nil && result != nil) {
                let friends = result.objectForKey("data") as NSArray
                for friend in friends {
                    first_name = friend.objectForKey("first_name") as String
                    last_name = friend.objectForKey("last_name") as String
                    name = friend.objectForKey("name") as String
                    id = friend.objectForKey("id") as String
                    profilePictureURL = NSURL(string: "http://graph.facebook.com/\(id)/picture?type=large")!
                    let fbFriend = FacebookFriend(first_name: first_name, last_name: last_name, name: name, id: id, profilePictureURL: profilePictureURL)
                    self.facebookFriends.append(fbFriend)
                    let fbFriendIndex = self.facebookFriends.count-1
//                    self.facebookFriendsCollectionView.insertItemsAtIndexPaths([fbFriendIndex])
                    self.facebookFriendsCollectionView.reloadData()
                }
            } else if (error != nil) {
                println("dat error: \(error.localizedDescription)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1 // Joined SocialDining already only, to add invite others to this page in the future
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println(facebookFriends.count)
        return facebookFriends.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("facebookFriendCell", forIndexPath: indexPath) as FacebookFriendCollectionCell
        cell.backgroundImage.image = nil
        let profPicURL = self.facebookFriends[indexPath.row].profilePictureURL
        

//        NSURLSession.sharedSession().dataTaskWithURL(profPicURL) { data, response, error in
//            if data == nil {
//                println("dataTaskWithURL error: \(error)")
//            } else {
//                println("well at least data's not nill")
//                if let image = UIImage(data: data) {
//                    println("well, data is something at least")
//                    dispatch_async(dispatch_get_main_queue()) {
//                        println("we received image")
//                        cell.backgroundImage.image = image
//                    }
//                }
//            }
//        }
        
        
        // synchronous right now, fix with code like that from above
        let data = NSData(contentsOfURL: profPicURL)
        cell.backgroundImage.image = UIImage(data: data!)
        cell.friendNameLabel.text = self.facebookFriends[indexPath.row].name
        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
