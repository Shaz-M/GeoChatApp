//
//  GeoChatAppApp.swift
//  GeoChatApp
//
//  Created by Shaz on 7/24/22.
//

import SwiftUI
import Firebase

@main
struct GeoChatAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            let viewModel = AuthViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
