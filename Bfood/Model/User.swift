//
//  User.swift
//  Bfood
//
//  Created by samer on 7/29/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation

struct User {
    
    let uid : String
    let username : String
    let profileImageUrl : String
    
    
    init(uid: String ,dic : [String: Any]) {
        
        username = dic["UserName"] as? String ?? ""
        profileImageUrl = dic["imageURL"] as? String ?? ""
        self.uid = uid
    }
    
}
