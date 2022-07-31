//
//  ChatView.swift
//  GeoChatApp
//
//  Created by Shaz on 7/30/22.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var vm: ChatViewModel
    @State private var text: String = ""
    
    let receiverUsername : String


    
    var body: some View {
            VStack {
                ScrollViewReader { proxy in
                    List(0 ..< self.vm.messages.count, id: \.self) { index in
                        MessageView(message: vm.messages[index],currentUser: vm.sender)
                            .tag(index)
                    }.listStyle(PlainListStyle())
                    .onChange(of: vm.messages, perform: { (_) in
                        proxy.scrollTo(vm.messages.count - 1)
                    })
                    .onAppear {
                        
                        let _ = print(vm.messages.count)
                        proxy.scrollTo(vm.messages.count - 1)
                    }
                    .padding(.top, 10)
                }
                
                HStack {
                    
                    TextField("Type your message!", text: $text)
                        .padding()
                        .font(.system(size: 16))
                        .frame(height: 40)
                        
                        .overlay(RoundedRectangle(cornerRadius: 30).strokeBorder(Color.gray.opacity(0.5), lineWidth: 1))
                    
                    Button {
                        self.vm.sendMessage(text: text)
                        text = ""
                    } label: {
                        Image(systemName: "arrow.forward.circle.fill")
                            .font(.system(size: 35))
                            
                    }
                }.padding(.horizontal)
                
                
            }.navigationTitle(receiverUsername).navigationBarTitleDisplayMode(.inline)
            .onAppear {
                UITableView.appearance().separatorColor = .clear
            }
           
        
        
    }
        
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(vm: ChatViewModel(sender: "", receiver: ""),receiverUsername: "Default User")
    }
}
