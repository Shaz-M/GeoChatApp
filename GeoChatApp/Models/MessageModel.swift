//
//  MessageModel.swift
//  GeoChatApp
//
//  Created by Shaz on 7/30/22.
//

import Foundation


struct Message: Codable,Hashable{
    var id = UUID().uuidString
    var text : String
    var senderUID : String
    
}
