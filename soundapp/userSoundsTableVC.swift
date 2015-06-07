//
//  friendListVC.swift
//  navigating
//
//  Created by Alicia Iott on 5/18/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse

class userSoundsTableVC: UITableViewController {
    
    var currentUser = PFUser.currentUser()
    var soundArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"reloadFriendListVC", object: nil)
        self.setSounds()
    }
    
    func setSounds(){
        var sounds = currentUser!["sounds"] as! [PFObject]
        for sound in sounds {
            sound.fetchIfNeededInBackgroundWithBlock({
                (object, error) -> Void in
                if (error == nil){
                    self.soundArray.append(sound["title"] as! String)
//                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.setSounds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(self.soundArray.count)
        return self.soundArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell4", forIndexPath: indexPath) as! soundCell
        
        cell.soundTitle.text = self.soundArray[indexPath.row]
        
        return cell
    }
}