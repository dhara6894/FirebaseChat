//
//  ChatDataStore.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 30/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import Foundation

class ChatDataStore{
    var cid: String?
    var rid: String?
    var userName: String?
    var message: String?
    var date: String?
  //  var userProfile: String?
    
    init(cid:String?,rid: String?,userName: String?,message: String?, date: String?) {
     self.cid = cid
     self.rid = rid
     self.userName = userName
     self.message = message
     self.date = date
     //self.userProfile = userProfile
    }
}
