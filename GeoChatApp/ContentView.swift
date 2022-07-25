//
//  ContentView.swift
//  GeoChatApp
//
//  Created by Shaz on 7/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var AuthViewModel : AuthViewModel
    var body: some View {
        NavigationView{
            if AuthViewModel.signedIn{
                ConversationListView()
            }
            else{
                SignInView()
            }
        }
        .onAppear{
            AuthViewModel.signedIn = AuthViewModel.isSignedIn
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
