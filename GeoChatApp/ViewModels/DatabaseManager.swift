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
}


// Mark: - Geofire Read/Write
struct FndDatabase{
    static let LOCATION = Database.database().reference().child("UserLocations")
    static let GEO_REF = GeoFire(firebaseRef: LOCATION)
}

extension DatabaseManager {
    public func setUserLocation(location: CLLocation){
        Auth.auth().addStateDidChangeListener { auth, user in
            if let uid = user{
                FndDatabase.GEO_REF.setLocation(location, forKey: uid.uid)
            }
        }
    }
    
    public func getNearbyUsers(location: CLLocation){
        let circleQuery = FndDatabase.GEO_REF.query(at: location, withRadius: 10)
        var users = [String]()
        circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
            users.append(key)
        })
        print(users)
    }
}
