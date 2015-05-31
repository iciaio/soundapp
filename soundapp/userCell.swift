//
//  userCell.swift
//  soundapp
//
//  Created by Alicia Iott on 5/27/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse

class userCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func requestFriend(sender: AnyObject) {
        let currentUser = PFUser.currentUser()
                
        var query = PFUser.query()
        query!.whereKey("username", equalTo: userNameLabel.text!)
        query!.getFirstObjectInBackgroundWithBlock{
            (user: PFObject?, error: NSError?) -> Void in
            if error != nil || user == nil {
                println("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                println("Successfully retrieved the object.")
                println((user as! PFUser).username)
                
                var newRequest = PFObject(className:"PendingTable")
                newRequest["to"] = user
                newRequest["from"] = currentUser
                newRequest.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                        println("success")
                    } else {
                        println("failed!:(")
                    }
                }
            }
        }
    }

}
