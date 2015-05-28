//
//  friendListVC.swift
//  navigating
//
//  Created by Alicia Iott on 5/18/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse

extension String {
    
    func findInString (stringToFind : String) -> Bool{
        if self != ""{
            if (self as NSString).containsString(stringToFind.lowercaseString){
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}




class addFriendVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchTextField: UISearchBar!
    var search = false
    var allUsers = [PFUser]()
    var dataSecond = [PFUser]()
    var mainData = PFUser()
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println("searchText \(searchText)")
        dataSecond = []
        if searchTextField.text == "" {
            search = false
            self.tableView.reloadData()
        }
        else {
            for user in allUsers{
                if (user.username! as String).lowercaseString.findInString(searchTextField.text){
                    dataSecond.append(user)
                }
            }
            search = true
            self.tableView.reloadData()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TEST CODE FOR FRIENDS LIST//
        var query = PFUser.query()
        
        query!.findObjectsInBackgroundWithBlock {
            
            (users: [AnyObject]?, error: NSError?) -> Void in
            
            if !(error != nil) {
                for user in users!{
                    self.allUsers.append(user as! PFUser)
                }
                self.tableView.reloadData()
            }
            else{
                println(error)
            }
        }
        
        searchTextField.delegate = self
        
        //TEST CODE END//
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search == true {
            return dataSecond.count
        }
        else{
            return allUsers.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if search == true{
            if dataSecond != [] {
                mainData = (dataSecond[indexPath.row])
            }
        }
        else {
            mainData = allUsers[indexPath.row]
        }
        var cell = self.tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as! userCell
        if let name = mainData.username{
            cell.userNameLabel.text = mainData.username
        }
        return cell
    }
    
        
//        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as! userCell
//        
//        cell.userNameLabel!.text = allUsers[indexPath.row].username
//        return cell

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
