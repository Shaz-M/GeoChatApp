//
//  ConversationListView.swift
//  GeoChatApp
//
//  Created by Shaz on 7/24/22.
//

import SwiftUI

struct ConversationListView: View {
    @EnvironmentObject var AuthViewModel : AuthViewModel
    
    var body: some View {
        VStack{
            Text("You are now signed in")
            
            Button(action: {
                    AuthViewModel.signOut()
            } , label:{
                    Text("Sign Out")
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .foregroundColor(Color.blue)
            })
        }
        
    }
}

struct ConversationListView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
    }
}
