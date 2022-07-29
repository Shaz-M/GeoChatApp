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
        VStack{
            NavigationView{
                List(ConversationViewModel.nearbyUsers){ user in
                    HStack{
                        Text(user.username)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Nearby Users")
            .navigationBarItems(trailing: Button(action: {
                AuthViewModel.signOut()
        } , label:{
                Text("Sign Out")
                .frame(width: 100, height: 50)
                .background(Color.black)
                .foregroundColor(Color.blue)
        }))
             
        }
        
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
