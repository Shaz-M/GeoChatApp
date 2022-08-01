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
                    NavigationLink(destination: ChatView(vm: ChatViewModel(sender:ConversationViewModel.currentuser, receiver: user.uid), receiverUsername: user.username)){
                        HStack{
                            Text(user.username)
                            Spacer()
                        }
                    }
                    .navigationBarItems(
                        leading: Text("Nearby Users")
                            .fontWeight(.bold)
                            .font(.largeTitle),
                        trailing: Button(action: {
                        AuthViewModel.signOut()
                } , label:{
                        Text("Sign Out")
                        .frame(width: 100, height: 50)
                        .background(Color.black)
                        .foregroundColor(Color.blue)
                }))
    
                }
                .navigationBarTitle("")
                .navigationBarHidden(false)
            }
            .padding(.top,30)

             
        
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
