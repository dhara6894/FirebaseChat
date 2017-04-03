//
//  ChatViewCell.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 30/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import UIKit



class LeftTableViewCell: UITableViewCell {

    @IBOutlet weak var IBviewBackground: UIView!
    @IBOutlet weak var IBlblDate: UILabel!
    @IBOutlet weak var IBlblMessage: UILabel!
    @IBOutlet weak var IBlblName: UILabel!
    @IBOutlet weak var IBimgProfilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


