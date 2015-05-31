//
//  friendListVC.swift
//  navigating
//
//  Created by Alicia Iott on 5/18/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse

class friendListVC: UITableViewController {
    
    var currentUser = PFUser.currentUser()
    var friendArray = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var friends = currentUser?["friends"] as! PFObject
        self.friendArray = friends["all_friends"]! as! [PFUser]
        println(self.friendArray.count)
        
        self.tableView.reloadData()
        
        //TEST CODE END//
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = friendArray[indexPath.row].username
        //println(friendArray[indexPath.row].username)
        return cell
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
