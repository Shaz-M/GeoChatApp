//
//  ConversationListView.swift
//  GeoChatApp
//
//  Created by Shaz on 7/24/22.
//

import SwiftUI

struct ConversationListView: View {
    @EnvironmentObject var AuthViewModel : AuthViewModel
    @ObservedObject var ConversationViewModel = ConversationListViewModel()
    
    init(){
        ConversationViewModel.getUsernames()
    }

    var body: some View {
            NavigationView{
                List(ConversationViewModel.nearbyUsers){ user in
                    MessageCell(destination: ChatView(vm: ChatViewModel(sender:ConversationViewModel.currentuser, receiver: user.uid), receiverUsername: user.username),name:user.username,message:user.email)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Nearby Users")
                .navigationBarItems(trailing: Button(action: {
                    AuthViewModel.signOut()
            } , label:{
                    Image(systemName: "power")
                    .background(Color.black)
                    .foregroundColor(Color.blue)
            }))
            }
            .navigationBarHidden(true)

             
        
    }
}


struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}


