//
//  MessageView.swift
//  GeoChatApp
//
//  Created by Shaz on 7/30/22.
//

import SwiftUI

struct Bubble: Shape {
    var sender: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, sender ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        return Path(path.cgPath)
    }
}

struct MessageView: View {
    
    var message: Message
    let currentUser : String
    
    var body: some View {
        HStack {
            if message.senderUID == currentUser {
                Spacer()
            }
            VStack {
                    Text(message.text)
                        .fontWeight(.medium)
                        .padding()
                        .foregroundColor(.white)
                        .background(currentUser == message.senderUID ? Color.blue : Color(.systemGray6))
                        .clipShape(Bubble(sender: currentUser == message.senderUID))
                    
            }
            if message.senderUID != currentUser {
                Spacer()
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message:Message(timestamp: 0, text: "Test message",senderUID: ""),currentUser: "")
    }
}
