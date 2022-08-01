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
        database.child("ChatMessages").child(chatID).queryOrdered(byChild: "timestamp").observe(.value){[weak self] snapshot in
            if snapshot.exists() {
                print(snapshot)
                self?.messages.removeAll()
                
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    guard let childDict = child.value as? [String: Any] else { continue }
                    let newMessage = Message(image_url:childDict["image_url"] as? String ?? "", timestamp: childDict["timestamp"] as! Int64, text: childDict["text"] as! String, senderUID: childDict["sender"] as! String)
                    self?.messages.append(newMessage)

                }
            }
        }
        
    }
    
    public func sendMessage(text:String,image_url:String){
        let message = Message(image_url: image_url, timestamp: Int64(Date().timeIntervalSince1970 * 1000),text: text, senderUID: sender)
        database.child("ChatMessages").child(chatID).child(message.id).setValue(               ["sender":message.senderUID,
            "timestamp":message.timestamp,
            "text":message.text,
            "image_url":image_url])
        
    }
    
    public func uploadImage(image:UIImage){
        FirebaseStorageManager.shared.uploadImage(conversationId: chatID, image: image) { [weak self] (url) in
            if url != nil {
                print("Url got it!!!!!")
                self?.sendMessage(text: "", image_url: url!.absoluteString)
                print("Image Uploaded!")
            }
        }
    }
}
