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
        
        LocationManager.shared.getUserLocation{location in
            DatabaseManager.shared.setUserLocation(location: location)
        }
        

    }
    
    func singUp(email: String, password: String, username:String){
        
        DatabaseManager.shared.userExists(with: email, completion: {[weak self] exists in
            guard !exists else{
                //user already exits error
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password){[weak self] result, error in
                guard result != nil, error == nil else{
                    return
                }
                // Sucess
                //insert username into database
                DatabaseManager.shared.insertUser(with: ChatAppUser(username:username,email:email))
                DatabaseManager.shared.insertEmail(uid: (result?.user.uid)!, email: email)
                
                DispatchQueue.main.async {
                    self?.signedIn = true
                }
            }
            
        })
        
        
        
        LocationManager.shared.getUserLocation{location in
            DatabaseManager.shared.setUserLocation(location: location)
        }
    

    }
    
    
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }

}
