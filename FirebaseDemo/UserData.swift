//
//  User.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 01/04/17.
//  Copyright © 2017 SA. All rights reserved.
//

import Foundation

class UserData{
    var uid: String?
    var firstname: String?
    var lastname: String?
    var username: String?
    var password: String?
    var isMine: Bool?
    
    init(uid:String?,firstname: String?,lastname: String?, username:String?, password: String?, isMine: Bool?){
        self.uid = uid
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.password = password
        self.isMine = isMine
    }
}
