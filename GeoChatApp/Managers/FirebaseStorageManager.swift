//
//  FirebaseStorageManager.swift
//  GeoChatApp
//
//  Created by Shaz on 7/31/22.
//

import Foundation
import FirebaseStorage


final class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    
    private let rootRef = Storage.storage().reference()
    
    
    func uploadImage(conversationId: String, image: UIImage, completion: @escaping((URL?) -> Void)) {
        
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            return
        }

        let imageName = UUID().uuidString + ".jpeg"
        
        let imageRef = rootRef.child("/chats/").child(conversationId).child(imageName)
        imageRef.putData(data, metadata: nil) { (metaData, error) in
            guard error == nil else {
                return
            }
            print("In Here. Got the download url!!!!")
            imageRef.downloadURL { (url, error) in
                if let downloadUrl = url {
                    completion(downloadUrl)
                }
            }
        }
        
        
    }
}
