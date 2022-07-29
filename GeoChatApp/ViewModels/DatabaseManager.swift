//
//  DatabaseManager.swift
//  GeoChatApp
//
//  Created by Shaz on 7/26/22.
//

import Foundation
import FirebaseDatabase
import GeoFire
import FirebaseAuth

final class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

// Mark: - Account Management
extension DatabaseManager{
    
    public func userExists(with email: String, completion: @escaping ((Bool)->Void)){
        
        let safeEmail = email.replacingOccurrences(of: ".", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else{
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    ///insert username to database
    public func insertUser(with user: ChatAppUser){
        database.child("Users").child(user.safeEmail).setValue(["username":user.username])
    }
    
    ///insert email to database
    public func insertEmail(uid: String,email:String){
        database.child("Emails").child(uid).setValue(["email":email])
    }
    
    public func getUsername(uid: String, completion: @escaping ((String)->Void)){
        database.child("Emails").child(uid).child("email").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            guard let email = snapshot.value as? String else{
                return
            }
            let safeEmail = email.replacingOccurrences(of: ".", with: "-")
            self?.database.child("Users").child(safeEmail).child("username").observeSingleEvent(of: .value, with: {snapshot in
                
                guard let username = snapshot.value as? String else{return}
                
                completion(username)
            })
            
        })
    }
    
}


// Mark: - Geofire Read/Write
struct FndDatabase{
    static let LOCATION = Database.database().reference().child("UserLocations")
    static let GEO_REF = GeoFire(firebaseRef: LOCATION)
}

extension DatabaseManager {
    public func setUserLocation(location: CLLocation){
        print("IN SET USER LOCATION")
        Auth.auth().addStateDidChangeListener { auth, user in
            if let uid = user{
                FndDatabase.GEO_REF.setLocation(location, forKey: uid.uid)
            }
        }
    }
    
    public func getNearbyUsers(location: CLLocation,completion: @escaping ([String]) -> Void) {
        let circleQuery = FndDatabase.GEO_REF.query(at: location, withRadius: 1.6)
        var users = [String]()
        circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
            users.append(key)
        })
        circleQuery.observeReady {
            completion(users)
        }
    }
}
