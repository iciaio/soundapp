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

    @IBAction func addFriend(sender: AnyObject) {
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
                
                //                    var friends : PFObject = currentUser?["friends"] as! PFObject
                //                    var friendArray : [PFUser] = friends["all_friends"] as! [PFUser]
                //                    friendArray.append(user as! PFUser)
                //                    friends["all_friends"] = friendArray
                
                //deal with multiple requests: must query for requests to this user already
                var newRequest = PFObject(className:"PendingTable")
                newRequest["to"] = currentUser
                newRequest["from"] = user
                newRequest.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        println("success")
                    } else {
                        println("failed!:(")
                    }
                }
            }
        }
    }
}
