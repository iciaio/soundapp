//
//  pendingUserCell.swift
//  soundapp
//
//  Created by Alicia Iott on 5/28/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse

class pendingUserCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var acceptButtonOutlet: UIButton!

    @IBAction func acceptRequest(sender: AnyObject) {
        println("accepted request! yay.")
    }
    
}
