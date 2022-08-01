//
//  MessageView.swift
//  GeoChatApp
//
//  Created by Shaz on 7/30/22.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct Bubble: Shape {
    var sender: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, sender ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        return Path(path.cgPath)
    }
}

struct FullImageView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var image_url: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                }.padding()
            }
            
            Spacer()
            AnimatedImage(url: URL(string: image_url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .background(Color.black)
            Spacer()
            
        }
    }
}

var width = UIScreen.main.bounds.width
struct MessageView: View {
    var message: Message
    var currentUser:String
    @State private var showFullImage = false
    var body: some View {
        HStack {
            if message.senderUID == currentUser {
                Spacer()
            }
            VStack {
                if message.image_url.count != 0 {
                    
                    AnimatedImage(url: URL(string: message.image_url))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (width / 1.5), height: (width / 1.5))
                        .cornerRadius(20.0)
                    
                } else {
                    Text(message.text)
                        .fontWeight(.medium)
                        .padding()
                        .foregroundColor(.white)
                        .background(currentUser == message.senderUID ? Color.blue : Color(.systemGray6))
                        .clipShape(Bubble(sender: currentUser == message.senderUID))
                }
                    
            }
            if message.senderUID != currentUser {
                Spacer()
            }
        }
        .onTapGesture {
            if message.image_url != "" {
                self.showFullImage.toggle()
            }
        }.sheet(isPresented: $showFullImage) {
            FullImageView(image_url: message.image_url)
        }
        
    }
}
