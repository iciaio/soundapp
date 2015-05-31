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
        var query = PFUser.query()
        query!.whereKey("username", equalTo: userNameLabel.text!)
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
                    self.addToEachFriendsTable()
                    NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
                }
            } else {
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
    }
    
    func addToEachFriendsTable(){
        
        println("adding to friends table here")
        
        
    }

}
