//
//  UserTableViewCell.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 31/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var IBlblUserName: UILabel!
    @IBOutlet weak var IBivUserProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
