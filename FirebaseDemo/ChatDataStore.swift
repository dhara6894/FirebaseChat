//
//  ChatDataStore.swift
//  FirebaseDemo
//
//  Created by dhara.patel on 30/03/17.
//  Copyright © 2017 SA. All rights reserved.
//

import Foundation

class ChatDataStore{
    
    var userName: String?
    var message: String?
    var date: String?
  //  var userProfile: String?
    
    init(userName: String?,message: String?, date: String?) {
        
     self.userName = userName
     self.message = message
     self.date = date
     //self.userProfile = userProfile
    }
}
