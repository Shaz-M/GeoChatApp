//
//  ChatViewModel.swift
//  GeoChatApp
//
//  Created by Shaz on 7/30/22.
//

import Foundation
import FirebaseDatabase

class ChatViewModel: ObservableObject {
    @Published var messages : [Message] = []
    var chatID: String = ""
    var sender = ""
    var receiver = ""
    
    private let database = Database.database().reference()
    
    init(sender:String, receiver:String){
        self.sender = sender
        self.receiver = receiver
        DatabaseManager.shared.getChatID(sender: sender, recevier: receiver){ id in
            self.chatID = id
            self.getMessages()
        }
    }
    
    public func getMessages(){
        database.child("ChatMessages").child(chatID).observe(.value){[weak self] snapshot in
            if snapshot.exists() {
                guard let data = snapshot.value as? [String: Any] else{
                    return
                }
                
                self?.messages.removeAll()
                let sortedKeys = Array(data.keys).sorted(by: <)
                sortedKeys.forEach { (key) in
                    if let messageDict = data[key] as? NSDictionary {
                        let newMessage = Message(text: messageDict["text"] as! String, senderUID:  messageDict["sender"] as! String)
                        self?.messages.append(newMessage)
                    }
                }
            }
        }
    }
    
    public func sendMessage(text:String){
        let message = Message(text: text, senderUID: sender)
        database.child("ChatMessages").child(chatID).child(message.id).setValue(["sender":message.senderUID, "text":message.text])
        
    }
}
