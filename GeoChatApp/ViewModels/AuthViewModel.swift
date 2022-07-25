//
//  AppViewModel.swift
//  GeoChatApp
//
//  Created by Shaz on 7/24/22.
//

import Foundation
import FirebaseAuth

//viewmodel for firebase login and logout auth

class AuthViewModel: ObservableObject{
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    func singIn(email: String, password: String){
        auth.signIn(withEmail: email,
                    password: password) {[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            // Sucess
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func singUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password){[weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            // Sucess
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }

}
