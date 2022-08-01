//
//  MessageModel.swift
//  GeoChatApp
//
//  Created by Shaz on 7/30/22.
//

import Foundation


struct Message: Codable,Hashable{
    var id = UUID().uuidString
    var image_url: String
    var timestamp : Int64
    var text : String
    var senderUID : String
    
}
