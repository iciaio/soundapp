//
//  friendListVC.swift
//  navigating
//
//  Created by Alicia Iott on 5/18/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse

class friendListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        
        // Do any additional setup after loading the view.
    }
    
    func getUsers(){
        var query = PFUser.query()
        query!.findObjectsInBackgroundWithBlock {
            (users: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(users!.count) users.")
                // Do something with the found objects
                if let users = users as? [PFUser] {
                    for user in users{
                        println(user.username)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
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
