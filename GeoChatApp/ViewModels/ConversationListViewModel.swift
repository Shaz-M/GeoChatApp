//
//  ConversationListViewModel.swift
//  GeoChatApp
//
//  Created by Shaz on 7/28/22.
//

import Foundation
import CoreLocation
import FirebaseDatabase
import FirebaseAuth

struct Chatroom: Identifiable {
    var id = UUID()
    var uid : String
    var username: String
}

class ConversationListViewModel: ObservableObject {
    
    @Published var nearbyUsers = [Chatroom]()
    let currentuser = Auth.auth().currentUser?.uid ?? ""
    
    public func getUsernames(){
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }

        let location = Database.database().reference().child("UserLocations").child(currentUserUid).child("l")
        
        location.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() { return }

            guard let arr = snapshot.value as? [CLLocationDegrees] else { return }
            
            if arr.count > 1 {

                let latitude = arr[0]

                let longitude = arr[1]
                
                DatabaseManager.shared.getNearbyUsers(location: CLLocation(latitude: latitude, longitude: longitude)){ array in
                    for uid in array{
                        if uid == currentUserUid{continue}
                        DatabaseManager.shared.getUsername(uid: uid){ value in
                            self.nearbyUsers.append(Chatroom(uid:uid,username: value))
                        }
                    }
                    
                }
            }

            
        })

    }
}
