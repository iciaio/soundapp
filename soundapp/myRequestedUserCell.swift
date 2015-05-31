//
//  myRequestedUserCell.swift
//  soundapp
//
//  Created by Alicia Iott on 5/29/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse

class myRequestedUserCell: UITableViewCell {
    
    let currentUser = PFUser.currentUser()
    var friend = PFUser()
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func acceptRequest(sender: AnyObject) {
        
        println("accepting request you stupid butthead")
        println(self.userNameLabel.text!)
        var query = PFUser.query()
        query!.whereKey("username", equalTo: self.userNameLabel.text!)
        query!.getFirstObjectInBackgroundWithBlock{
            (user: AnyObject?, error: NSError?) -> Void in
            if !(error != nil) {
                println("hereeee")
                self.friend = user as! PFUser!
                self.queryPending()
            }
            else{
                println(error)
            }
        }
        
    }
    
    func queryPending(){
        
        var pendingQuery = PFQuery(className:"PendingTable")
        pendingQuery.whereKey("to", equalTo: PFUser.currentUser()!)
        pendingQuery.whereKey("from", equalTo: self.friend)
        pendingQuery.findObjectsInBackgroundWithBlock {
            (requests: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                for request in requests! {
                    request.deleteInBackground()
                }
                self.addToEachFriendsTable()
            } else {
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
    }
    
    func addToEachFriendsTable(){
                
        
        var currentUserFriends : PFObject = self.currentUser!["friends"] as! PFObject
        currentUserFriends.addObject(self.friend, forKey: "all_friends")
        
        currentUserFriends.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                
                var friendFriends : PFObject = self.friend["friends"] as! PFObject
                friendFriends.addObject(self.currentUser!, forKey: "all_friends")
                
                friendFriends.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                    }
                }
            }
        }
    }
    
}
