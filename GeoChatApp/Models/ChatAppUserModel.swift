//
//  ChatAppUserModel.swift
//  GeoChatApp
//
//  Created by Shaz on 7/26/22.
//

import Foundation

struct ChatAppUser{
    let username: String
    let email: String
    
    var safeEmail: String{
        let safeEmail = email.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
}
